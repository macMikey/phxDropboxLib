*phxDropboxLib v1.12*
**Introduction:**

<span style="text-decoration: none"><span
style="font-weight: normal">The </span></span><span
style="text-decoration: none">**phxDropboxLib**</span><span
style="text-decoration: none"><span style="font-weight: normal"> is a
Livecode library to access Dropbox using the REST API. Is totally
written in Livecode using only the HTTP GET, the HTTP PUT
and</span></span>

<span style="text-decoration: none"><span
style="font-weight: normal">the HTTP POST and should run on ANY Livecode
platform.</span></span>


<span style="text-decoration: none"><span
style="font-weight: normal">Currently, all the functions are blocking.
The current release of Livecode doesn't have non-blocking functions for
the HTTP PUT and HTTP POST functions, which are the tasks that require
more time (</span></span>*<span style="text-decoration: none"><span
style="font-weight: normal">all other HTTP GET function return very
quickly</span></span>*<span style="font-style: normal"><span
style="text-decoration: none"><span
style="font-weight: normal">).</span></span></span>



<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">I have
NOT implemented all the Dropbox REST API's (</span></span></span>*<span
style="text-decoration: none"><span style="font-weight: normal">and not
all possible parameters for the ones I have
implemented</span></span>*<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">), but,
I hope, the most useful ones are included.</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">Future
releases will implement more functions.</span></span></span>


<span style="font-style: normal">**Copyright:**</span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">(c)
2001-2016 Phoenix Sistemi & Automazione s.a.g.l. - Muralto (TI)-
Switzerland - All Rights Reserved Worldwide.</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span
style="font-weight: normal">http://www.phoenixsea.ch</span></span></span>


<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">You can
use this library under the terms of the </span></span></span><span
style="font-style: normal"><span style="text-decoration: none">**MIT
License**</span></span><span style="font-style: normal"><span
style="text-decoration: none"><span
style="font-weight: normal">.</span></span></span>


<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">Support
eMail : guglielmo.braguglia@phoenixsea.ch</span></span></span>


<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">If you
like this library and you want to support the development, you can make
a free little donation by </span></span></span><span
style="font-style: normal"><span
style="text-decoration: none">**PayPal**</span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">to this
e-Mail : guglielmo.braguglia@citynet.ch</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">Thank
you in advance.</span></span></span>



<span style="font-style: normal">**Revision History:**</span>



<span style="font-style: normal"><span
style="text-decoration: none">**1.02**</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> : first public release</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none">**1.03**</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> : added pLimit and pList to function
phx\_DropboxGetFileInfo</span></span></span>

<span style="text-decoration: none"> <span
style="font-style: normal"><span style="font-weight: normal">: added
pLimit to function phx\_DropboxGetFileList</span></span></span>

<span style="text-decoration: none"> <span
style="font-style: normal"><span style="font-weight: normal">: added new
function phx\_DropboxMoveFile pRoot, pFromPath,
pToPath</span></span></span>

<span style="text-decoration: none"> <span
style="font-style: normal"><span style="font-weight: normal">: corrected
some Err: messages</span></span></span>

<span style="text-decoration: none"> <span
style="font-style: normal"><span style="font-weight: normal">: some
corrections made by Mike Kerner marked as : \#mikey</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none">**1.04** </span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal">: fixed WriteFile code on mobile devices
(PUSH) - corrections made by Mike Kerner marked as :
\#mikey</span></span></span>

<span style="text-decoration: none"> <span
style="font-style: normal"><span
style="font-weight: normal">documentation typo corrections - thanks to
Mike Kerner</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none">**1.05**</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> : fixed a really obscure issue that could
cause a failure on mobile after writing a file</span></span></span>

<span style="text-decoration: none"> <span
style="font-style: normal"><span style="font-weight: normal">: added
some documentation to the code here and there</span></span></span>

<span style="text-decoration: none"> <span
style="font-style: normal"><span style="font-weight: normal">:
corrections made by Mike Kerner marked as : \#mikey</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none">**1.06**</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> : for mobile, EVERY URL has to be sent
through rfcURLEncode, or it will not be handled.</span></span></span>

<span style="text-decoration: none"> <span
style="font-style: normal"><span style="font-weight: normal">:
corrections made by Mike Kerner marked as : \#mikey</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none">**1.07**</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> : fixed an unecessary URLEncode in
phx\_DropboxWriteFile</span></span></span>

<span style="text-decoration: none"> <span
style="font-style: normal"><span style="font-weight: normal">: fixed an
unecessary URLEncode in phx\_DropboxGetFileList</span></span></span>

<span style="text-decoration: none"> <span
style="font-style: normal"><span style="font-weight: normal">: added new
function phx\_DropboxCreateLinkToFile pRoot, pPath,
pShortURL</span></span></span>

<span style="text-decoration: none"> <span
style="font-style: normal"><span style="font-weight: normal">:
correction and new function made by Trevor DeVore marked as :
\#TKD</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none">**1.08**</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> : added code to encode spaces in paths
where necessary b/c LC handles URL's differently on mobile and
desktop</span></span></span>

<span style="text-decoration: none"> <span
style="font-style: normal"><span style="font-weight: normal">:
corrections made by Mike Kerner marked as : \#mikey</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none">**1.09**</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> : added rfcURLDecode, which converts
escaped character sequences (% followed by a hex pair), useful for
making a filename human-readable</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal"> : added
isHex, for checking if a character is hex or not</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal"> :
changed rfcUrlEncode to not private b/c if we need to be able to encode
filenames that include slashes, such as “2/20/15 photos”. If we don’t
then</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal"> : if we
pass a path and a filename with slashes, dropbox will naturally assume
that we’re adding extra directories.</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal"> : added
misc stack handlers (openStack, openCard, preOpenStack, closeCard,
closeStack) so developers working in the library won’t get messages
from</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal"> : their
parent stack.</span></span></span>

<span style="text-decoration: none"> <span
style="font-style: normal"><span style="font-weight: normal">: Changes
made by Mike Kerner marked as : \#mikey</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none">**1.10** </span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal">: fixed the phx\_DropboxAvailable to
recognize a differente error message from DropBox
and</span></span></span>

<span style="text-decoration: none"> <span
style="font-style: normal"><span style="font-weight: normal">: to verify
the DropBox availabiliy.</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none">**1.11** </span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal">: fixed typo introduced by Mikey when I was
fixing the version-out-of-sequence issue that came in with 1.09/1.10
(fix by mikey)</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none">**1.12** </span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal">: dropbox changed the way it handles error
responses since 1.09/1.10. Updated phx\_dropboxAvailable.
\#mikey</span></span></span>





<span style="font-style: normal">**Function syntax:**</span>



<span style="font-style: normal"><span
style="text-decoration: none">**function**</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> phx\_DropboxLibVersion</span></span></span>



<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">Call
this function to retrieve the library version</span></span></span>

<span style="font-style: normal"><span
style="font-weight: normal">Return:</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> the lib version in the format
n.nn</span></span></span>




<span style="font-style: normal"><span
style="text-decoration: none">**function**</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> phx\_DropboxAvailable</span></span></span>


<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">Call
this function to verify if the connection with the Dropbox server is
available.</span></span></span>

<span style="font-style: normal"><span
style="font-weight: normal">Return:</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> a boolean </span></span></span><span
style="font-style: normal"><span
style="text-decoration: none">**true**</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> if the connection is available,
</span></span></span><span style="font-style: normal"><span
style="text-decoration: none">**false**</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> if can't reach the Dropbox
server</span></span></span>




<span style="font-style: normal"><span
style="text-decoration: none">**function**</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> phx\_DropboxInitLib pAppKey, pAppSec,
pTokKey, pTokSec</span></span></span>



<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">You must
call this function before any other function to initialize the
library.</span></span></span>



<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">pAppKey
: is your Application key assigned by Dropbox</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">pAppSec
: is your Application Secret still assigned by
Dropbox</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">pTokKey
: (if the user has already authorized the application) is the Token key
returned by the phx\_DropboxAuthorized() otherwise leave
empty</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">pTokSec
: (if the user has already authorized the application) is the Token
secret returned by the phx\_DropboxAuthorized() otherwise leave
empty</span></span></span>

<span style="font-style: normal"><span
style="font-weight: normal">Return:</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> empty if all is ok or an error message
beginning with "Err:" if there is an error.</span></span></span>




<span style="font-style: normal"><span
style="text-decoration: none">**function**</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> phx\_DropboxReqToken
pCallback</span></span></span>



<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">If the
user has not already authorized the application, you have to call this
function to get the https page address where the user can enter
his</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span
style="font-weight: normal">credentials and authorize the application.
If possible you can open a browser window on the returned https address,
if not possible, give the</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">link to
the user and ask him to open a browser, enter the link and authorize the
application.</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span
style="font-weight: normal">Unfortunately, for security reasons, is not
possible to enter the user credentials from the
application.</span></span></span>



<span style="font-style: normal"><span
style="text-decoration: none"><span
style="font-weight: normal">pCallback : if not empty, after the user
authorize an application, the user is redirected to the application
served URL provided by this parameter</span></span></span>

<span style="font-style: normal"><span
style="font-weight: normal">Return :</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> the https link if all is ok or an error
message beginning with "Err:" if there is an error.
</span></span></span>




<span style="font-style: normal"><span
style="text-decoration: none">**function**</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> phx\_DropboxAuthorized</span></span></span>



<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">Only
after the user has authorized the application, you can get the
application tokens with this call. You have to save the returned tokens
so, on the</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span
style="font-weight: normal">following runs, you don't have to authorize
the application again (</span></span></span>*<span
style="text-decoration: none"><span style="font-weight: normal">the
tokens never expire</span></span>*<span style="font-style: normal"><span
style="text-decoration: none"><span
style="font-weight: normal">).</span></span></span>



<span style="font-style: normal"><span
style="font-weight: normal">Return:</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> a three row string containing "the token
key, a carriage return, the token secret, a carriage return, the user
Id" if all is ok or an error</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">message
beginning with "Err:" if there is an error. </span></span></span>




<span style="font-style: normal"><span
style="text-decoration: none">**function**</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> phx\_DropboxGetInfo</span></span></span>



<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">Call
this function if you want to get information about the user
account.</span></span></span>



<span style="font-style: normal"><span
style="font-weight: normal">Return:</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> a JSON structure with the User account
information if all is ok or an error message beginning with "Err:" if
there is an error.</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">For more
info on the JSON-returned structure, please see :
https://www.dropbox.com/developers/reference/api\#account-info</span></span></span>




<span style="font-style: normal"><span
style="text-decoration: none">**function**</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> phx\_DropboxGetFileList pRoot, pPath, pStr,
pIncDel, pLimit</span></span></span>



<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">Call
this function if you want to retrieve the metadata for all files and
folders whose filename contains the given search string as a
substring.</span></span></span>



<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">pRoot :
can be only "dropbox" or "sandbox"</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">pPath :
the path to the folder you want to search from
(</span></span></span>*<span style="text-decoration: none"><span
style="font-weight: normal">you can leave empty for the
root</span></span>*<span style="font-style: normal"><span
style="text-decoration: none"><span
style="font-weight: normal">)</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">pStr :
the search string. </span></span></span>*<span
style="text-decoration: none"><span style="font-weight: normal">Must be
at least three characters long</span></span>*

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">pIncDel
: boolean, pass true if you want to include the "deleted" otherwise pass
false</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">pLimit :
the maximum and default value is 1,000. No more than pLimit search
results will be returned., </span></span></span>

<span style="font-style: normal"><span
style="font-weight: normal">Return :</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> a JSON structure with the list of metadata
entries for any matching files and folders if all is ok or an error
message beginning with "Err:"</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">if there
is an error.</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">For more
info on the JSON returned structure, please see :
https://www.dropbox.com/developers/reference/api\#search</span></span></span>




<span style="font-style: normal"><span
style="text-decoration: none">**function**</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> phx\_DropboxReadFile pRoot, pPath,
pRevision</span></span></span>



<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">Call
this function to read the content of a file.</span></span></span>



<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">pRoot :
can be only "dropbox" or "sandbox"</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">pPath :
the path to the file you want to retrieve</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span
style="font-weight: normal">pRevision : the revision of the file to
retrieve. This defaults to the most recent revision</span></span></span>

<span style="font-style: normal"><span
style="font-weight: normal">Return :</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> the specified file's contents at the
requested revision if all is ok or an error message beginning with
"Err:" if there is an error.</span></span></span>



<span style="font-style: normal"><span
style="text-decoration: none">**function**</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> phx\_DropboxGetFileInfo pRoot, pPath,
pLimit, pList</span></span></span>



<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">Call
this function to retrieve file and folder metadata.</span></span></span>



<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">pRoot :
can be only "dropbox" or "sandbox"</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">pPath :
the path to the file or folder</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">pLimit :
the default is 10,000 (max is 25,000). When listing a folder, the
service will not report listings containing more than the
specified</span></span></span>

<span style="text-decoration: none"> <span
style="font-style: normal"><span style="font-weight: normal">amount of
files and will instead respond with a 406.</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">pList :
if true or omitted, the folder's metadata will include a contents field
with a list of metadata entries for the contents of the
folder.</span></span></span>

<span style="text-decoration: none"> <span
style="font-style: normal"><span style="font-weight: normal">If false,
the contents field will be omitted.</span></span></span>

<span style="font-style: normal"><span
style="font-weight: normal">Return:</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> a JSON structure with the metadata for the
file or folder if all is ok or an error message beginning with "Err:" if
there is an error.</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">For more
info on the JSON returned structure, please see :
https://www.dropbox.com/developers/reference/api\#metadata</span></span></span>




<span style="font-style: normal"><span
style="text-decoration: none">**function**</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> phx\_DropboxGetFileThumb pRoot, pPath,
pFormat, pSize</span></span></span>



<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">Call
this function to get a thumbnail for an image.</span></span></span>



<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">pRoot :
can be only "dropbox" or "sandbox"</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">pPath :
the path to the image file you want to thumbnail</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">pFormat:
can be only "jpeg" or "png"</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">pSize :
can be only "small", "medium", "large" "s", "m", "l" and
"xl"</span></span></span>

<span style="font-style: normal"><span
style="font-weight: normal">Return :</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> a thumbnail of the specified image's
contents if all is ok or an error message beginning with "Err:" if there
is an error. The image returned</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">may be
larger or smaller than the size requested, depending on the size and
aspect ratio of the original image.</span></span></span>




<span style="font-style: normal"><span
style="text-decoration: none">**function**</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> phx\_DropboxShareFile pRoot, pPath,
pShort</span></span></span>



<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">Call
this function to read the content of a file.</span></span></span>



<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">pRoot :
can be only "dropbox" or "sandbox"</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">pPath :
the path to the file you want to retrieve</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">pShort :
When true, the url returned will be shortened using the Dropbox url
shortener. If false, the url will link directly to the file's preview
page</span></span></span>

<span style="font-style: normal"><span
style="font-weight: normal">Return :</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> a JSON structure with a Dropbox link to the
given path if all is ok, or an error message beginning with "Err:" if
there is an error.</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">For more
info on the JSON returned structure, please see :
https://www.dropbox.com/developers/reference/api\#shares</span></span></span>



<span style="font-style: normal"><span
style="text-decoration: none">**function**</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> phx\_DropboxWriteFile pRoot, pPath,
pContentType, pOverWrite, pData</span></span></span>



<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">Call
this function to write a file.</span></span></span>


<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">pRoot :
can be only "dropbox" or "sandbox"</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">pPath :
the path to the file you want to write to</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span
style="font-weight: normal">pContentType : MIME standard content type
(</span></span></span>*<span style="text-decoration: none"><span
style="font-weight: normal">you can use "application/octet-stream" for
any type of file</span></span>*<span style="font-style: normal"><span
style="text-decoration: none"><span
style="font-weight: normal">)</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span
style="font-weight: normal">pOverWrite : boolen value, either true
(</span></span></span>*<span style="text-decoration: none"><span
style="font-weight: normal">default</span></span>*<span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal">) or false, determines what happens when
there's already a file at the specified path. If true, the existing
file</span></span></span>

<span style="text-decoration: none"> <span
style="font-style: normal"><span style="font-weight: normal">will be
overwritten by the new one. If false, the new file will be automatically
renamed (for example, test.txt might be automatically renamed
to</span></span></span>

<span style="text-decoration: none"> <span
style="font-style: normal"><span style="font-weight: normal">test
(1).txt). The new name can be obtained from the returned
metadata</span></span></span>

<span style="font-style: normal"><span
style="font-weight: normal">Return :</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> a JSON structure with the metadata for the
uploaded file if all is ok or an error message beginning with "Err:" if
there is an error.</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">For more
info on the JSON returned structure, please see :
https://www.dropbox.com/developers/reference/api\#files\_put</span></span></span>



<span style="font-style: normal"><span
style="text-decoration: none">**function**</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> phx\_DropboxDeleteFile pRoot,
pPath</span></span></span>



<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">Call
this function to delete a file or folder.</span></span></span>



<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">pRoot :
can be only "dropbox" or "sandbox"</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">pPath :
the path to the file or folder to delete</span></span></span>

<span style="font-style: normal"><span
style="font-weight: normal">Return:</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> a JSON structure with the metadata for the
deleted file or folder if all is ok or an error message beginning with
"Err:" if there is an error.</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">For more
info on the JSON returned structure, please see :
https://www.dropbox.com/developers/reference/api\#fileops-delete</span></span></span>



<span style="font-style: normal"><span
style="text-decoration: none">**function**</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> phx\_DropboxMoveFile pRoot, pFromPath,
pToPath</span></span></span>



<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">Call
this function to move a file or folder.</span></span></span>



<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">pRoot :
can be only "dropbox" or "sandbox"</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span
style="font-weight: normal">pFromPath : specifies the file or folder to
be moved from relative to root</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">pToPath
: specifies the destination path, including the new name for the file or
folder, relative to root</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">Return :
a JSON structure with the metadata for the moved file or folder if all
is ok or an error message beginning with "Err:" if there is an
error.</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">For more
info on the JSON returned structure, please see :
https://www.dropbox.com/developers/reference/api\#fileops-move</span></span></span>




<span style="font-style: normal"><span
style="text-decoration: none">**function**</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> phx\_DropboxCreateFolder pRoot,
pPath</span></span></span>



<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">Call
this function to create a folder.</span></span></span>



<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">pRoot :
can be only "dropbox" or "sandbox"</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">pPath :
the path to the folder to create relative to
"pRoot"</span></span></span>

<span style="font-style: normal"><span
style="font-weight: normal">Return:</span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal"> a JSON structure with metadata the for the
created folder if all is ok or an error message beginning with "Err:" if
there is an error.</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">For more
info on the JSON returned structure, please see :
https://www.dropbox.com/developers/reference/api\#fileops-create-folder</span></span></span>




<span style="font-style: normal"><span
style="text-decoration: none">**function** </span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal">phx\_DropboxCreateLinkToFile pRoot, pPath,
pShortURL</span></span></span>



<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">Call
this function to create a Dropbox link to files or folders users can use
to view a preview of the file in a web browser.</span></span></span>



<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">pRoot :
can be only "dropbox" or "sandbox"</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">pPath :
</span></span></span><span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">path to
the file or folder you want to link to</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span
style="font-weight: normal">pShortURL : when true (default), the url
returned will be shortened using the Dropbox url shortener. If false,
the url will link </span></span></span>

<span style="text-decoration: none"> <span
style="font-style: normal"><span style="font-weight: normal">directly to
the file's preview page.</span></span></span>

<span style="font-style: normal"><span
style="font-weight: normal">Return </span></span><span
style="font-style: normal"><span style="text-decoration: none"><span
style="font-weight: normal">: a JSON structure with
</span></span></span><span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">a
Dropbox link to the given path. The link can be used publicly and
directs to a preview page of the</span></span></span>

<span style="text-decoration: none"> <span
style="font-style: normal"><span style="font-weight: normal">file. For
compatibility reasons, it returns the link's expiration date in
Dropbox's usual date format. All links are currently
set</span></span></span>

<span style="text-decoration: none"> <span
style="font-style: normal"><span style="font-weight: normal">to expire
far enough in the future so that expiration is effectively not an
issue.</span></span></span>

<span style="font-style: normal"><span
style="text-decoration: none"><span style="font-weight: normal">For more
info on the JSON returned structure, please see :
https://www.dropbox.com/developers/core/docs\#shares</span></span></span>
