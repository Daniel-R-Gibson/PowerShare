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


![Image](daniel-r-gibson.github.io/powershare/pictures/file-explorer ps.jpeg)


- All end-user facing elements are MS Office applications, enabling any user to easily understand the tool. These other documents in the PowerShare directory are also all linked to the PowerShare PowerPoint document--thus preventing any documents from de-syncing with the Master File before it gets copied over to the local desktop. 


![Image](daniel-r-gibson.github.io/powershare/pictures/file-explorer ps.jpeg)


- This PowerShare PowerPoint Document is also the document that the Auto_Updater script copys to the Displaying workstation whenever a change is detected on the PowerShare Directory.


![Image](daniel-r-gibson.github.io/powershare/pictures/file-explorer ps.jpeg)


- The PowerShare package also includes an installer and Read Me which guide the Admin through the process of installing, maintaining, and updating the PowerShare Utility.


![Image](daniel-r-gibson.github.io/powershare/pictures/file-explorer ps.jpeg)


- Additionally, The Powershare package also includes a script that continually checks for connectivity to the Network Drive and launches a warning if a connection is not detected. 


![Image](daniel-r-gibson.github.io/powershare/pictures/file-explorer ps.jpeg)


# Requirements:
- One Dedicated Workstation (Windows 10 Operating System)
- 1 Account with Administrative Rights
- Task Scheduler
- PowerShell
- Microsoft Office Application Suite

## Welcome to GitHub Pages

You can use the [editor on GitHub](https://github.com/Daniel-R-Gibson/PowerShare/edit/main/README.md) to maintain and preview the content for your website in Markdown files.

Whenever you commit to this repository, GitHub Pages will run [Jekyll](https://jekyllrb.com/) to rebuild the pages in your site, from the content in your Markdown files.

### Markdown

Markdown is a lightweight and easy-to-use syntax for styling your writing. It includes conventions for

```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3

- Bulleted
- List

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src)
```

For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

### Jekyll Themes

Your Pages site will use the layout and styles from the Jekyll theme you have selected in your [repository settings](https://github.com/Daniel-R-Gibson/PowerShare/settings). The name of this theme is saved in the Jekyll `_config.yml` configuration file.

### Support or Contact

Having trouble with Pages? Check out our [documentation](https://docs.github.com/categories/github-pages-basics/) or [contact support](https://github.com/contact) and we’ll help you sort it out.
