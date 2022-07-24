# iblood

## Intro
Hi! 

iblood is a mobile application built with flutter framework. It has many features including:
- Blood bank tab, which displays:
	- Blood bank info.
	- Available blood types.
- Public donors tab, which displays the donors that accepted to be a public donors. The user can click on each donor card and see their contact info.
- Private community tab, which displays the registered private communities, for example: universities or any other institutions. For now there is no admin dashboard so Institutions can only be created directly from the firebase firestore that are connected to the app. To be a member of any community you need to have a membership code which can be obtained from the community owner, if you are a community owner ( have an "editor" role ), you can add new members and copy the invitation code or "membership code" and send it to who ever you want ( notice that invitation code can be associated with one user only ). If you have a membership code you can enter to a community, which include:
	-  Monitor the Donors and donation requests of the community.
	- Add yourself as a donor inside this community.
	- Add a donation request. When a donation request is added, all of the members will recieve a notification.
	- See the statistics of the community
- Account tab, where you can:
	- Activate your account ( an activation code can only be obtained from the blood bank when you donate blood ).
	- See your personal info ( need activation ).
	- See your balance ( need activation ).
	- See your donation archive ( need activation ).
	- logout.

## How To run

 1. Setting up your Firebase:
	- Firestore:
		- create two firestore databases, one for the iblood app and the other fore the bloodbank system, download the google-services.json files and put them in your project in "android/app/".![google-services.json directory image](https://github.com/maath9826/iblood-public/blob/master/README-images/gs-dir.png?raw=true)



		- make sure that the structure of the databases is as follows:![database structure image](https://github.com/maath9826/iblood-public/blob/master/README-images/all.png?raw=true)![database structure image](https://github.com/maath9826/iblood-public/blob/master/README-images/database3.1.png?raw=true)
	- Authentication:
		- make authentication with Email/Password.
 3. run "flutter pub get".