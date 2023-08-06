---
title:        VisualStudio
permalink:    DotNetNotes/VisualStudio
category:     DotNetNotes
parent:       DotNetNotes
layout:       default
has_children: false
share:        true
shortRepo:
  - dotnetnotes
  - default
---


<br/>

<details markdown="block">
<summary>
Table of contents
</summary>
{: .text-delta }
1. TOC
{:toc}
</details>

<br/>

***

<br/>

# [Shortcuts](https://learn.microsoft.com/en-us/visualstudio/ide/finding-and-replacing-text?view=vs-2022#multi-caret-selection)

* <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + click : Add a secondary caret
* <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + double-click : Add a secondary word selection
* <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + click + drag : Add a secondary selection
* <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>.</kbd> : Add the next matching text as a selection
* <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>;</kbd> : Add all matching text as selections
* <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>,</kbd> : Remove last selected occurrence
* <kbd>Shift</kbd> + <kbd>Alt</kbd> + <kbd>/</kbd> : Skip next matching occurrence
* <kbd>Alt</kbd> + click : Add a box selection
* <kbd>Esc</kbd> or click : Clear all selections

Some of those commands are also available in the `Edit` menu:

![Multiple Carets Menu][2]

[1]: https://learn.microsoft.com/en-us/visualstudio/ide/finding-and-replacing-text#multi-caret-selection

[2]: https://i.stack.imgur.com/J1WkX.png

[3]: https://i.stack.imgur.com/OlNMI.png

# Console

## [Nuget](https://learn.microsoft.com/en-us/nuget/reference/ps-reference/ps-ref-get-project)

- Port packages from one project to another

```powershell
Get-Package -ProjectName 'SourceProject\LogicalPath\Source.Project.Name' | ForEach-Object { Install-Package -Id $_.Id -Version $_.Versions -Projectname 'TargetProject\LogicalPath\Target.Project.Name' }
```

```shell
Get-Project -All | Add-BindingRedirect

# or

 Get-Project MyProject | Add-BindingRedirect
```

```shell
Update-Package -Reinstall Antlr
```

***

# Extentions

## Useful

- [Keep History of file changes](https://marketplace.visualstudio.com/items?itemName=KenCross.VSHistory2022)

## Code Formatters

### Native VS options

- [change formatting in vs  settings](https://learn.microsoft.com/en-us/visualstudio/ide/reference/options-text-editor-csharp-formatting?view=vs-2022#formatting-general-page)
- [use an EditorConfigFile](https://learn.microsoft.com/en-us/visualstudio/ide/create-portable-custom-editor-options?view=vs-2019)

### Plugins

- [CSharpier is an opinionated code formatter for c#](https://csharpier.com/docs/About)
- [CSharpier VS plugin](https://marketplace.visualstudio.com/items?itemName=csharpier.csharpier-vscode)
- [Code Maid](https://marketplace.visualstudio.com/items?itemName=SteveCadwallader.CodeMaid)
- [dotnet/format](https://github.com/dotnet/format)

### Linters

- [Jet Brains Resharper](https://www.jetbrains.com/resharper/)
- [SonarLint docs](https://www.sonarsource.com/products/sonarlint/features/)
- [SonarLint Plugin](https://marketplace.visualstudio.com/items?itemName=SonarSource.SonarLintforVisualStudio2022)