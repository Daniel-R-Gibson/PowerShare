# What it does:

- The PowerShare uses the simple and familiar Microsoft Office Applications to provide users (or the DJC2 Staff) with a easy to use tool for the sharing of mission updates,  information, and annoucements on a VisMaster Display. (_VisMaster is a desktop sharing tool developed for the DJC2. Think 'HDMI over IP'_)


- The PowerShare PowerPoint document serves as the single point of distrobution for various Mircosoft Office documents in the PowerShare folder--All of which are linked to the PowerPoint document. 


- As soon as a change on any document within the PowerShare folder is detected, the displayed PowerPoint will update with the new changes.
Additionally, becuase every user has both access and familiarity to the sharedrive and the PowerShare folder, the flow of information to other users 
is increased.


- One may ask, how is this different than _any other_ PowerPoint document saved to a Network Drive?
The key differnce lies in the local saving of a copy of the PowerPoint to the workstation that displays the PowerPoint through VisMaster.
Because a powerpoint is saved and displayed locally, the UserShare copy (and any linked documents inside the PowerShare folder) are free to update.


# How it works:

- The PowerShare tool uses The PowerShare PowerPoint document as the focus for all of the other documents in the PowerShare directory. 


![Image](/PowerShare/pictures/File-Explorer PS.PNG)


- All end-user facing elements are MS Office applications, enabling any user to easily understand the tool. These other documents in the PowerShare directory are also all linked to the PowerShare PowerPoint document--thus preventing any documents from de-syncing with the Master File before it gets copied over to the local desktop. 


![Image](/PowerShare/pictures/slide1.PNG) 
![Image](/PowerShare/pictures/slide2.PNG)


- This PowerShare PowerPoint Document is also the document that the Auto_Updater script copys to the Displaying workstation whenever a change is detected on the PowerShare Directory.


- The PowerShare package also includes an installer and Read Me which guide the Admin through the process of installing, maintaining, and updating the PowerShare Utility.


![Image](/PowerShare/pictures/isntaller1 ps.png)
![Image](/PowerShare/pictures/installer2 ps.png)


- Additionally, The Powershare package also includes a script that continually checks for connectivity to the Network Drive and launches a warning if a connection is not detected. 


![Image](/PowerShare/pictures/warning.PNG) 


# Requirements:
- One Dedicated Workstation (Windows 10 Operating System)
- 1 Account with Administrative Rights
- Task Scheduler
- PowerShell
- Microsoft Office Application Suite

## [View PowerShare Package and Source Code on Github](https://github.com/Daniel-R-Gibson/Powershare/)




