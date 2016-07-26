# Building Without DRM

01. `git clone https://github.com/NYPL/Simplified-iOS.git` or `git clone git@github.com:NYPL-Simplified/Simplified-iOS.git`
02. `cd Simplified-iOS`
03. `git submodule update --init --recursive`
04. Install [Cocoapods](https://cocoapods.org) if you haven't already.
05. `pod install`
06. `open Simplified.xcworkspace`
07. Build.

# Enabling Support for Adobe DRM

01. Follow the steps for "Building Without DRM".
02. Symlink the "DRM_Connector_Prerelease" directory to "adobe-rmsdk". *You will need to have obtained the Adobe DRM Connector prerelease from Adobe.*
03. Follow the instructions in "adobe-rmsdk/RMSDK_User_Manual(obj).pdf" to build OpenSSL (section 12.1) and cURL (section 12.3).
04. `./adobe-rmsdk-build`
05. `git clone https://github.com/NYPL/DRM-iOS-Adobe.git adept-ios` or `git clone git@github.com:NYPL-Simplified/DRM-iOS-Adobe.git adept-ios`
06. `git clone https://github.com/NYPL/Adobe-Content-Filter.git adobe-content-filter` or `git clone git@github.com:NYPL-Simplified/Adobe-Content-Filter.git adobe-content-filter`
07. `./drm-adobe-enable`
08. `open Simplified.xcworkspace`
09. Build.

# Disabling Support for Adobe DRM

01. `./drm-adobe-disable`

# Contributing

This codebase follows [Google's Objective-C Style Guide](https://google.github.io/styleguide/objcguide.xml)
including the use of two-space indentation. Both Objective-C and Swift may be
used for new code.

The primary services/singletons within the program are as follows:

* `NYPLAccount`
* `NYPLBookCoverRegistry` (used directly only by `NYPLBookRegistry`)
* `NYPLBookRegistry`
* `NYPLConfiguration`
* `NYPLKeychain`
* `NYPLMyBooksDownloadCenter`

All of the above contain appropriate documentation in the header files.

The rest of the program follows Apple's usual pattern of passive views,
relatively passive models, and one-off controllers for integrating everything.
Immutability is preferred wherever possible.

Questions and suggestions should be submitted as GitHub issues and tagged with
the appropriate labels. More in-depth discussion occurs via Slack: Email
`jamesenglish@nypl.org` for access.

# License

Copyright © 2015 The New York Public Library, Astor, Lenox, and Tilden Foundations

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
