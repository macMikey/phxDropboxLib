// ------------------------------------------------------------------
// phxDropboxLib 1.12
//
// (c) 2001-2016 Phoenix Sistemi & Automazione s.a.g.l. - Muralto (TI)
// Switzerland - All Rights Reserved Worldwide.
// http://www.phoenixsea.ch/
//
// You can use this library under the terms of the MIT License
//
// Support eMail : guglielmo.braguglia@phoenixsea.ch
//
// If you want to support the developement you can do a free donation by PayPal
// to this eMail :  guglielmo.braguglia@citynet.ch  - Thanks !
//
// The DB core REST API is documented at https://www.dropbox.com/developers/core/docs
//
// Revision History :
// 1.02 : first public release
// 1.03 : added pLimit and pList to function phx_DropboxGetFileInfo
//         : added pLimit to function phx_DropboxGetFileList
//         : added new function phx_DropboxMoveFile pRoot, pFromPath, pToPath
//         : corrected some Err: messages
//         : some corrections made by Mike Kerner marked as : #mikey
// 1.04 : fixed WriteFile code on mobile devices (PUSH)
//         : corrections made by Mike Kerner marked as : #mikey
// 1.05 : fixed a really obscure issue that could cause a failure on mobile after writing a file
//         : added some documentation to the code here and there
//         : corrections made by Mike Kerner marked as : #mikey
// 1.06 : for mobile, EVERY URL has to be sent through rfcURLEncode, or it will not be handled.
//         : corrections made by Mike Kerner marked as : #mikey
// 1.07 : fixed an unecessary URLEncode in phx_DropboxWriteFile
//         : fixed an unecessary URLEncode in phx_DropboxGetFileList
//         : added new function phx_DropboxCreateLinkToFile pRoot, pPath, pShortURL
//         : correction and new function made by Trevor DeVore marked as : #TKD
// 1.08 : STILL fiddling with paths and filenames to deal with reserved characters and spaces.
//         : LC treats URL's differently on desktop and mobile.
//         : Changes made by Mike Kerner, marked as: #mikey
// 1.09 : Added rfcURLDecode and isHex so when we retrieve the filenames we can (easily) get a human-readable version
//         : Added isHex, used by rfcURLDecode to check if the two characters after a % are hex or not.  IN THEORY every
//         : % in a filename/path should be followed by a hex pair (indicating the ASCII character to be substituted), but I'm not
//         : assuming anything.
//         : Made rfcURLEncode un-private b/c we should be able to encode a filename before we pass it with a path, because if a filename
//         : has slashes as part of the name, we can't encode them later (since we wouldn't know if the slashes are part of the name
//         : like /myHappyPlace/filename or if they were part of a filename like "2/20/15 files".
//         : Also added oreOpenStack, openStack, openCard, closeCard, and closeStack handlers so a parent stack doesn't freak out
//         : if this gets opened by the developer.
//         : Changes are by Mike Kerner, marked as: #mikey
// 1.10  : Fixed the phx_DropboxAvailable to recognize a different error message from dropbox and to verify availability.
// 1.11  : Fixed typo in the phx_DropboxAvailable.  Mikey fixing his own mistake...
// 1.12  : Mikey: It looks like the error message that dropbox is returning in response to the query that phx_dropboxAvailable is sending has changed since 1.11.  Changed what we're looking for.
//
// ------------------------------------------------------------------

//
// ----------------------------- constant ----------------------------
//
constant phx_DropboxLibVer = "1.12"
constant unreservedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.~"

//
// --------------------------- local variables --------------------------
//
local phx_ApplicationKey, phx_ApplicationSecret, phx_TokenKey, phx_TokenSecret, phx_UId
local tURL, tAnswer
local libraryStackHandled #mikey

//
// ---------------------------- libraryStack ---------------------------
//
on libraryStack
   -- set the initial configuration when the library is placed in use (start using)
   if libraryStackHandled then pass libraryStack #mikey so we don't wipe the keys and such if we do a START USING on another stack that does not have a libraryStack handler in it.
   put empty into phx_ApplicationKey
   put empty into phx_ApplicationSecret
   put empty into phx_TokenKey
   put empty into phx_TokenSecret
   put true  into libraryStackHandled #mikey
end libraryStack

#<v. 1.09>
//
// ---------------------------- misc handlers ---------------------------
// #mikey
//
on preOpenStack
   #just catch it so if we open the stack while it's attached to another stack we don't have a panic attack in the parent.
end preOpenStack

on openStack
   #just catch it so if we open the stack while it's attached to another stack we don't have a panic attack in the parent.
end openStack

on openCard
   #just catch it so if we open the stack while it's attached to another stack we don't have a panic attack in the parent.
end openCard

on closeCard
      #just catch it so if we open the stack while it's attached to another stack we don't have a panic attack in the parent.
end closeCard

on closeStack
      #just catch it so if we open the stack while it's attached to another stack we don't have a panic attack in the parent.
end closeStack
#</v. 1.09>

//
// --------------------------- releaseStack ---------------------------
//
on releaseStack
   -- set the final configuration when a stack is no longer in use (stop using)

end releaseStack

//
// -------------------------- rfcURLEncode --------------------------
//
function rfcURLEncode pInput isAPath #mikey was private
   local tOutput, tHex
   --
   put empty into tOutput
   repeat for each char tChar in pInput
      if tChar is in unreservedChars or (tChar is "/" and isAPath) then #v. 1.08 mikey added (tChar is "/" and isAPath) so we encode everything but unreserved and slash
         put tChar after tOutput
      else
         get binaryDecode("H*", tChar, tHex)
         put "%" & tHex after tOutput
      end if
   end repeat
   return tOutput
end rfcURLEncode

#<v. 1.09>
//
// -------------------------- rfcURLDecode --------------------------
// # mikey I DO NOT want this to be private.  I want the user to be able to get a human-readable version of a filename.
//
function rfcURLDecode what
   #takes a string that includes %-encoded characters and converts each of them to an ascii character.
   put 0 into charsToSkip
   put offset("%",what) into position
   repeat until position=0
      add charsToSkip to position # makes the math easier to read if we just use the absolute positioning from the beginning.
      put char position+1 to position+2 of what into maybeHex #step past the % and get the next 2 chars
      # due to the way we do the encoding in the dropbox library, those two characters SHOULD be a hex string (because we even encode
      # the % character in the dropbox library, so the only reason for it to show up here is because it is inserted to delimit a hex
      # representation of an ascii character.
      if isHex(char 1 of maybeHex) and isHex(char 2 of maybeHex) then # we have an encode character
         put binaryEncode("H*",maybeHex) into char position to position+2 of what # replace the 3 char % and hex string with the char
         put position into charsToSkip #move past either the % that didn't have a hex string after it, or the character we just
         #inserted.  Yes, we could move past a couple more in cases where we have a non-hex following a %, but meh.
         put offset("%",what,charsToSkip) into position
      end if #(char 1 of maybeHex) and isHex(char 2 of maybeHex)
   end repeat #until position=0
   return what
end rfcURLDecode
#</v. 1.09>

#<v. 1.09>
//
// -------------------------- isHex --------------------------
// #mikey
//
function isHex what
   #determines if "what" is hex or not
   if what is in "0123456789ABCDEF" then return true else return false # also, LC isn't case-sensitive
end isHex
#</v. 1.09>

//
// -------------------------- prepareOauth --------------------------
//
private function prepareOauth
   local tTime, tOnce, tKey, tOAuth
   --
   put the seconds into tTime
   put base64Encode(md5Digest(tTime)) into tOnce
   put rfcURLencode(phx_ApplicationSecret & "&" & phx_TokenSecret) into tKey
   --
   put "oauth_consumer_key=" & phx_ApplicationKey & "&" into tOAuth
   if (phx_TokenKey is not empty) then
      put "oauth_token=" & phx_TokenKey & "&" after tOAuth
   end if
   put "oauth_signature_method=" & "PLAINTEXT" & "&" after tOAuth
   put "oauth_signature=" & tKey & "&" after tOAuth
   put "oauth_timestamp=" & tTime & "&" after tOAuth
   put "oauth_nonce=" & tOnce & "&" after tOAuth
   put "oauth_version=1.0" after tOAuth
   return tOAuth
end prepareOauth

//
// -------------------------- verifyNoInit ----------------------------
//
private function verifyNoInit
   if  ( (phx_ApplicationKey is empty) or (phx_ApplicationSecret is empty) or \
         (phx_TokenKey is empty) or (phx_TokenSecret is empty) ) then return true
   else return false
end verifyNoInit

//
// ----------------------------------------------------------------
//

//
// ---------------------- phx_DropboxLibVersion -----------------------
//
function phx_DropboxLibVersion
   return phx_DropboxLibVer
end phx_DropboxLibVersion

//
// ------------------------ phx_DropboxInitLib ------------------------
//
function phx_DropboxInitLib pAppKey, pAppSec, pTokKey, pTokSec
   if ( (pAppKey is empty) or (pAppSec is empty) ) then return "Err: No Application info"
   put pAppKey into phx_ApplicationKey
   put pAppSec into phx_ApplicationSecret
   if ( (pTokKey is not empty) and (pTokSec is not empty) ) then
      put pTokKey into phx_TokenKey
      put pTokSec into phx_TokenSecret
   end if
   return empty
end phx_DropboxInitLib

//
// ---------------------- phx_DropboxAvailable ------------------------
//
function phx_DropboxAvailable
   # yes, this is correct - we know DB is available if we send a malformed request to it and get an error back.
   # no, there is no other good way to do it.
   put "https://api.dropbox.com/1/oauth/access_token?" into tURL #v. 1.11 #v. 1.10
   put  URL tUrl into tAnswer
   if tAnswer begins with ( "{" & quote & "error_description" & quote) then return true #v. 1.12 error message changed?
   else return false
end phx_DropboxAvailable

//
// ---------------------- phx_DropboxReqToken -----------------------
//
function phx_DropboxReqToken pCallback
   if ( (phx_ApplicationKey is empty) or (phx_ApplicationSecret is empty) ) then return "Err: Bad Initialization"
   --
   put empty into phx_TokenKey
   put empty into phx_TokenSecret
   put "https://api.dropbox.com/1/oauth/request_token?" into tURL
   put prepareOauth() after tURL
   put  URL tUrl into tAnswer
   if tAnswer contains "error" then return "Err: Unable to get request token" & cr & tAnswer
   --
   set the itemDelimiter to "&"
   repeat for each item tItem in tAnswer
      if tItem begins with "oauth_token_secret=" then
         delete char 1 to 19 of tItem
         put tItem into phx_TokenSecret
      else if tItem begins with "oauth_token=" then
         delete char 1 to 12 of tItem
         put tItem into phx_TokenKey
      end if
   end repeat
   set the itemDelimiter to comma
   if ( (phx_TokenKey is empty) or (phx_TokenSecret is empty) ) then return "Err: Unable to get request token"
   --
   put "https://www.dropbox.com/1/oauth/authorize?" into tURL
   put "oauth_token=" & phx_TokenKey after tURL
   if pCallback is not empty then
      put "&" & "oauth_callback=" & pCallback after tURL
   end if
   return tURL
end phx_DropboxReqToken

//
// --------------------- phx_DropboxAuthorized -----------------------
//
function phx_DropboxAuthorized
   if verifyNoInit() then return "Err: Bad Initialization"
   --
   put "https://api.dropbox.com/1/oauth/access_token?" into tURL
   put prepareOauth() after tURL
   put  URL tUrl into tAnswer
   if tAnswer contains "error" then return "Err: Unable to get access token" & cr & tAnswer
   --
   set the itemDelimiter to "&"
   repeat for each item tItem in tAnswer
      if tItem begins with "oauth_token_secret=" then
         delete char 1 to 19 of tItem
         put tItem into phx_TokenSecret
      else if tItem begins with "oauth_token=" then
         delete char 1 to 12 of tItem
         put tItem into phx_TokenKey
      else if tItem begins with "uid=" then
         delete char 1 to 4 of tItem
         put tItem into phx_UId
      end if
   end repeat
   set the itemDelimiter to comma
   if ( (phx_TokenKey is empty) or (phx_TokenSecret is empty) ) then return "Err: Unable to get access token"
   --
   return phx_TokenKey & cr & phx_TokenSecret & cr & phx_UId
end phx_DropboxAuthorized

//
// --------------------- phx_DropboxGetInfo -----------------------
//
function phx_DropboxGetInfo
   if verifyNoInit() then return "Err: Bad Initialization"
   --
   put "https://api.dropbox.com/1/account/info?" into tURL
   put prepareOauth() after tURL
   put  URL tUrl into tAnswer
   if tAnswer contains "error" then return "Err: Unable to get user info" & cr & tAnswer
   else return tAnswer
end phx_DropboxGetInfo

//
// -------------------- phx_DropboxGetFileInfo ---------------------
//
function phx_DropboxGetFileInfo pRoot, pPath, pLimit, pList
   if verifyNoInit() then return "Err: Bad Initialization"
   --
   put rfcURLEncode(pPath,true) into pPath #v. 1.08 mikey added true so oath and path coding can use same function #v. 1.06 Mikey
   if ( (pRoot is not "dropbox") and (pRoot is not "sandbox") ) then return "Err: Invalid root param"
   put "https://api.dropbox.com/1/metadata/" & pRoot & "/" & pPath & "?" into tURL
   if (pLimit is not empty) and isNumber(pLimit) and ( (pLimit > 0) and (pLimit < 25000) ) then
      put "file_limit=" & pLimit & "&" after tURL
   end if
   if (pList is not empty) and (pList is false) then
      put "list=false" & "&" after tURL
   end if
   put prepareOauth() after tURL
   put  URL tUrl into tAnswer
   if tAnswer contains "error" then return "Err: Unable to get files metadata" & cr & tAnswer
   else return tAnswer
end phx_DropboxGetFileInfo

//
// -------------------- phx_DropboxGetFileList ---------------------
//
function phx_DropboxGetFileList pRoot, pPath, pStr, pIncDel, pLimit
   if verifyNoInit() then return "Err: Bad Initialization"
   --
   put rfcURLEncode(pPath,true) into pPath #v. 1.08 mikey added true so oath and path coding can use same function #v. 1.06 Mikey
   put rfcURLEncode(pStr,true) into pStr #v. 1.08 mikey restored b/c a space in a name needs to be encoded #v. 1.06 Mikey  #v. 1.07 TKD
   if ( (pRoot is not "dropbox") and (pRoot is not "sandbox") ) then return "Err: Invalid root param"
   put "https://api.dropbox.com/1/search/" & pRoot & "/" & pPath & "?" into tURL
   put "query=" & pStr & "&" after tURL
   if ( (pIncDel is empty) or (pIncDel is false) ) then
      put "include_deleted=false" & "&" after tURL
   else
      put "include_deleted=true" & "&" after tURL
   end if
   if (pLimit is not empty) and isNumber(pLimit) then
      put "file_limit=" & pLimit & "&" after tURL
   end if
   put prepareOauth() after tURL
   put  URL tUrl into tAnswer
   if tAnswer contains "error" then return "Err: Unable to find files" & cr & tAnswer
   else return tAnswer
end phx_DropboxGetFileList

//
// ------------------ phx_DropboxGetFileThumb --------------------
//
function phx_DropboxGetFileThumb pRoot, pPath, pFormat, pSize
   if verifyNoInit() then return "Err: Bad Initialization"
   --
  put rfcURLEncode(pPath,true) into pPath #v. 1.08 mikey added true so oath and path coding can use same function #v. 1.06 Mikey
   if ( (pRoot is not "dropbox") and (pRoot is not "sandbox") ) then return "Err: Invalid root param"
   put "https://api-content.dropbox.com/1/thumbnails/" & pRoot & "/" & pPath & "?" into tURL
   if (pFormat is not empty) then
      if ( (pFormat is not "jpeg") and (pFormat is not "png") ) then return "Err: Invalid format param"
      else put "format=" & pFormat & "&" after tURL
   end if
   if (pSize is not empty) then
      if (pSize is not among the items of "small,medium,large,s,m,l,xl") then return "Err: Invalid size param"
      else put "size=" & pSize & "&" after tURL
   end if
   put prepareOauth() after tURL
   put  URL tUrl into tAnswer
   if the result is not empty then return "Err: Unable to get file thumbnail" & cr & the result
   else return tAnswer
end phx_DropboxGetFileThumb

//
// --------------------- phx_DropboxReadFile ---------------------
//
function phx_DropboxReadFile pRoot, pPath, pRevision
   if verifyNoInit() then return "Err: Bad Initialization"
   --
  put rfcURLEncode(pPath,true) into pPath #v. 1.08 mikey added true so oath and path coding can use same function #v. 1.06 Mikey
   if ( (pRoot is not "dropbox") and (pRoot is not "sandbox") ) then return "Err: Invalid root param"
   put "https://api-content.dropbox.com/1/files/" & pRoot & "/" & pPath & "?" into tURL
   if (pRevision is not empty) then
      put "rev=" & pRevision  & "&" after tURL
   end if
   put prepareOauth() after tURL
   put  URL tUrl into tAnswer
   if the result is not empty then return "Err: Unable to read file" &cr& the result
   else return tAnswer
end phx_DropboxReadFile
//
// -------------------- phx_DropboxDeleteFile ---------------------
//
function phx_DropboxDeleteFile pRoot, pPath
   if verifyNoInit() then return "Err: Bad Initialization"
   --
  put rfcURLEncode(pPath,true) into pPath #v. 1.08 mikey added true so oath and path coding can use same function #v. 1.06 Mikey
   if ( (pRoot is not "dropbox") and (pRoot is not "sandbox") ) then return "Err: Invalid root param"
   put "https://api.dropbox.com/1/fileops/delete?" into tURL
   put "root=" & pRoot  & "&" after tURL
   put "path=" & pPath & "&" after tURL
   put prepareOauth() after tURL
   put  URL tUrl into tAnswer
   if tAnswer contains "error" then return "Err: Unable to delete files" & cr & tAnswer
   else return tAnswer
end  phx_DropboxDeleteFile

//
// --------------------- phx_DropboxMoveFile ---------------------
//
function phx_DropboxMoveFile pRoot, pFromPath, pToPath
   if verifyNoInit() then return "Err: Bad Initialization"
   --
   put rfcURLEncode(pFromPath,true) into pPath #v. 1.08 mikey added true so oath and path coding can use same function #v. 1.06 Mikey
   put rfcURLEncode(pToPath,true) into pPath #v. 1.08 mikey added true so oath and path coding can use same function #v. 1.06 Mikey
   if ( (pRoot is not "dropbox") and (pRoot is not "sandbox") ) then return "Err: Invalid root param"
   put "https://api.dropbox.com/1/fileops/move?" into tURL
   put "root=" & pRoot  & "&" after tURL
   put "from_path=" & pFromPath & "&" after tURL
   put "to_path=" & pToPath & "&" after tURL
   put prepareOauth() after tURL
   put  URL tUrl into tAnswer
   if tAnswer contains "error" then return "Err: Unable to move files" & cr & tAnswer
   else return tAnswer
end phx_DropboxMoveFile

//
// -------------------- phx_DropboxCreateFolder ---------------------
//
function phx_DropboxCreateFolder pRoot, pPath
   if verifyNoInit() then return "Err: Bad Initialization"
   --
   put rfcURLEncode(pPath,true) into pPath #v. 1.08 mikey added true so oath and path coding can use same function #v. 1.06 Mikey
   if ( (pRoot is not "dropbox") and (pRoot is not "sandbox") ) then return "Err: Invalid root param"
   put "https://api.dropbox.com/1/fileops/create_folder?" into tURL
   put "root=" & pRoot  & "&" after tURL
   put "path=" & pPath & "&" after tURL
   put prepareOauth() after tURL
   put  URL tUrl into tAnswer
   if tAnswer contains "error" then return "Err: Unable to create folder" & cr & tAnswer
   else return tAnswer
end phx_DropboxCreateFolder

//
// -------------------- phx_DropboxWriteFile ----------------------
//
function phx_DropboxWriteFile pRoot, pPath, pContentType, pOverWrite, pData
   local tCRLF, tBoundary, tDataHead, tDataPost, tDataLng
   local tTime, tOnce, tKey
   local oldDelimiter, theFilename, thePath, oldHTTPHeaders
   --
   if verifyNoInit() then return "Err: Bad Initialization"
   --
   put rfcURLEncode(pPath,true) into pPath #v. 1.08 mikey added true so oath and path coding can use same function #v. 1.06 Mikey
   // put rfcURLEncode(pData) into pData #v. 1.06 Mikey #v. 1.07 TKD
   if ( (pRoot is not "dropbox") and (pRoot is not "sandbox") ) then return "Err: Invalid root param"
   if (pContentType is empty) then return "Err: Invalid content type"
   --
   if the environment is "mobile" then
      -- on iOS and Android CAN'T use HTTP PUT, so we have to use the HTTP POST
      -- which is much more complex than a simple HTTP PUT.
      put empty into tDataHead
      put empty into tDataPost
      put 0 into tDataLng
      put ( numToChar(13) & numToChar(10) ) into tCRLF
      put "----------GPB9876543210" into tBoundary
      ------ first create the BODY of HTTP POST
      put tCRLF & "--" & tBoundary & tCRLF into tDataPost
      #<mikey - support folders in the path>
      put the itemDelimiter into oldDelimiter
      set the itemDelimiter to "/"
      put the last item of pPath into theFilename
      delete last item of pPath
      put pPath into thePath # the real path. The rest is the filename

      put theFilename into pPath
      set the itemDelimiter to oldDelimiter
      #</mikey - support folders in the path>
      put "Content-Disposition: form-data; name=" & quote & "file" & quote & "; " & \
            "filename=" & quote & pPath & quote & "; " & "overwrite=" & quote after tDataPost
      if (pOverWrite is false) then
         put "false" & quote & tCRLF after tDataPost
      else
         put "true" & quote & tCRLF after tDataPost
      end if
      put "Content-Type: application/octet-stream" & tCRLF & tCRLF after tDataPost
      put pData after tDataPost
      put tCRLF & "--" & tBoundary & "--" & tCRLF after tDataPost
      put (the length of tDataPost) into tDataLng
      ------ after create the HEADER of the HTTP POST
      put the seconds into tTime
      put base64Encode(md5Digest(tTime)) into tOnce
      put rfcURLencode(phx_ApplicationSecret & "&" & phx_TokenSecret) into tKey
      --
      put "Host: api-content.dropbox.com" & cr into tDataHead
      put "Authorization: OAuth file=" & quote & pPath & quote & "," after tDataHead
      put "oauth_consumer_key=" & quote & phx_ApplicationKey & quote & "," after tDataHead
      put "oauth_nonce=" & quote & tOnce & quote & "," after tDataHead
      put "oauth_signature=" & quote & tKey & quote & "," after tDataHead
      put "oauth_signature_method=" & quote & "PLAINTEXT" & quote & "," after tDataHead
      put "oauth_timestamp=" & quote & tTime & quote & "," after tDataHead
      put "oauth_token=" & quote & phx_TokenKey & quote & "," after tDataHead
      put "oauth_version=" & quote & "1.0" & quote & cr after tDataHead
      put "Connection: close" & cr after tDataHead
      put "Content-Type: multipart/form-data; boundary=" & tBoundary & cr after tDataHead
      // on HTTP/1.1 the content lenght is not necessary
      // put "Content-Length: " & tDataLng & cr after tDataHead
      ------ then create the URL
      put "https://api-content.dropbox.com/1/files/" & pRoot & "/"&thePath into tURL #Mikey added thePath
      ------ finally make the HTTP POST
      put the httpHeaders into oldHTTPHeaders #v. 1.05 mikey
      set the httpHeaders to tDataHead
      post tDataPost to URL tURL
      set the httpheaders to oldHTTPHeaders#v. 1.05 mikey
      if the result is not empty then return "Err: Unable to write file" & cr & the result & cr & the urlResponse
      else return the urlResponse
   else
       -- on desktop can use HTTP PUT
      set the httpHeaders to "Content-Type: " & pContentType
      put "https://api-content.dropbox.com/1/files_put/" & pRoot & "/" & pPath & "?" into tURL
      if (pOverWrite is false) then
         put "overwrite=false" & "&" after tURL
      else
         put "overwrite=true" & "&" after tURL
      end if
      put prepareOauth() after tURL
      put pData into URL tURL
      if the result is not empty then return "Err: Unable to write file" & cr & the result & cr & the urlResponse
      else return the urlResponse
   end if
end phx_DropboxWriteFile
//
// --------------- phx_DropboxCreateLinkToFile --------------------
// #v. 1.07 TKD 2013-09-17
//
function phx_DropboxCreateLinkToFile pRoot, pPath, pShortURL
      if verifyNoInit() then return "Err: Bad Initialization"
      --
   put rfcURLEncode(pPath,true) into pPath #v. 1.08 mikey added true so oath and path coding can use same function #v. 1.06 Mikey
    if ( (pRoot is not "dropbox") and (pRoot is not "sandbox") ) then return "Err: Invalid root param"
      
      put "https://api.dropbox.com/1/shares/" & pRoot & "/" & pPath & "?" into tURL
      if pShortURL is true then
            put "short_url=true" & "&" after tURL
      else
            put "short_url=false" & "&" after tURL
      end if
      put prepareOauth() after tURL
      POST empty to URL tUrl
      put it into tAnswer
      if tAnswer contains "error" then return "Err: Unable to create share" & cr & tAnswer
      else return tAnswer
end phx_DropboxCreateLinkToFile
