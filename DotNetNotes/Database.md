---
title:        Database
permalink:    DotNetNotes/Database
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

# Type Comparisons

<table cellspacing="1" cellpadding="7" width="548" border="1">
<tbody>
<tr>
<td width="34%" style="border:1px solid #e1e2e2; padding:5px"><b>
</b><p align="center"><b>.NET Framework Type</b></p>
</td>
<td width="35%" style="border:1px solid #e1e2e2; padding:5px"><b>
</b><p align="center"><b>ADO.NET Database Type</b></p>
</td>
<td width="31%" style="border:1px solid #e1e2e2; padding:5px"><b>
</b><p align="center"><b>SQL Data Type</b></p>
</td>
</tr>
<tr>
<td width="34%" style="border:1px solid #e1e2e2; padding:5px">
<p>String</p>
</td>
<td width="35%" style="border:1px solid #e1e2e2; padding:5px">
<p>Varchar </p>
</td>
<td width="31%" style="border:1px solid #e1e2e2; padding:5px">
<p>Varchar()</p>
</td>
</tr>
<tr>
<td width="34%" style="border:1px solid #e1e2e2; padding:5px">
<p>String</p>
</td>
<td width="35%" style="border:1px solid #e1e2e2; padding:5px">
<p>Nvarchar</p>
</td>
<td width="31%" style="border:1px solid #e1e2e2; padding:5px">
<p>Nvarchar()</p>
</td>
</tr>
<tr>
<td width="34%" style="border:1px solid #e1e2e2; padding:5px">
<p>String</p>
</td>
<td width="35%" style="border:1px solid #e1e2e2; padding:5px">
<p>NChar</p>
</td>
<td width="31%" style="border:1px solid #e1e2e2; padding:5px">
<p>Nchar()</p>
</td>
</tr>
<tr>
<td width="34%" style="border:1px solid #e1e2e2; padding:5px">
<p>String</p>
</td>
<td width="35%" style="border:1px solid #e1e2e2; padding:5px">
<p>NText</p>
</td>
<td width="31%" style="border:1px solid #e1e2e2; padding:5px">
<p>NText</p>
</td>
</tr>
<tr>
<td width="34%" style="border:1px solid #e1e2e2; padding:5px">
<p>String</p>
</td>
<td width="35%" style="border:1px solid #e1e2e2; padding:5px">
<p>Text</p>
</td>
<td width="31%" style="border:1px solid #e1e2e2; padding:5px">
<p>Text</p>
</td>
</tr>
<tr>
<td width="34%" style="border:1px solid #e1e2e2; padding:5px">
<p>Double</p>
</td>
<td width="35%" style="border:1px solid #e1e2e2; padding:5px">
<p>BigInt</p>
</td>
<td width="31%" style="border:1px solid #e1e2e2; padding:5px">
<p>Float</p>
</td>
</tr>
<tr>
<td width="34%" style="border:1px solid #e1e2e2; padding:5px">
<p>DateTime</p>
</td>
<td width="35%" style="border:1px solid #e1e2e2; padding:5px">
<p>DateTime</p>
</td>
<td width="31%" style="border:1px solid #e1e2e2; padding:5px">
<p>Datetime</p>
</td>
</tr>
<tr>
<td width="34%" style="border:1px solid #e1e2e2; padding:5px">
<p>DateTime</p>
</td>
<td width="35%" style="border:1px solid #e1e2e2; padding:5px">
<p>SmallDateTime</p>
</td>
<td width="31%" style="border:1px solid #e1e2e2; padding:5px">
<p>Smalldatetime</p>
</td>
</tr>
<tr>
<td width="34%" style="border:1px solid #e1e2e2; padding:5px">
<p>Int</p>
</td>
<td width="35%" style="border:1px solid #e1e2e2; padding:5px">
<p>Int</p>
</td>
<td width="31%" style="border:1px solid #e1e2e2; padding:5px">
<p>Int</p>
</td>
</tr>
<tr>
<td width="34%" style="border:1px solid #e1e2e2; padding:5px">
<p>Int64</p>
</td>
<td width="35%" style="border:1px solid #e1e2e2; padding:5px">
<p>BigInt</p>
</td>
<td width="31%" style="border:1px solid #e1e2e2; padding:5px">
<p>Bigint</p>
</td>
</tr>
<tr>
<td width="34%" style="border:1px solid #e1e2e2; padding:5px">
<p>Int16</p>
</td>
<td width="35%" style="border:1px solid #e1e2e2; padding:5px">
<p>SmallInt</p>
</td>
<td width="31%" style="border:1px solid #e1e2e2; padding:5px">
<p>smallint</p>
</td>
</tr>
<tr>
<td width="34%" style="border:1px solid #e1e2e2; padding:5px">
<p>Byte[]</p>
</td>
<td width="35%" style="border:1px solid #e1e2e2; padding:5px">
<p>Binary</p>
</td>
<td width="31%" style="border:1px solid #e1e2e2; padding:5px">
<p>Binary()</p>
</td>
</tr>
<tr>
<td width="34%" style="border:1px solid #e1e2e2; padding:5px">
<p>Byte[]</p>
</td>
<td width="35%" style="border:1px solid #e1e2e2; padding:5px">
<p>Image</p>
</td>
<td width="31%" style="border:1px solid #e1e2e2; padding:5px">
<p>Image</p>
</td>
</tr>
<tr>
<td width="34%" style="border:1px solid #e1e2e2; padding:5px">
<p>Byte[]</p>
</td>
<td width="35%" style="border:1px solid #e1e2e2; padding:5px">
<p>VarBinary</p>
</td>
<td width="31%" style="border:1px solid #e1e2e2; padding:5px">
<p>Varbinary()</p>
</td>
</tr>
<tr>
<td width="34%" style="border:1px solid #e1e2e2; padding:5px">
<p>Byte</p>
</td>
<td width="35%" style="border:1px solid #e1e2e2; padding:5px">
<p>TinyInt</p>
</td>
<td width="31%" style="border:1px solid #e1e2e2; padding:5px">
<p>Tinyint</p>
</td>
</tr>
<tr>
<td width="34%" style="border:1px solid #e1e2e2; padding:5px">
<p>Bool</p>
</td>
<td width="35%" style="border:1px solid #e1e2e2; padding:5px">
<p>Bit</p>
</td>
<td width="31%" style="border:1px solid #e1e2e2; padding:5px">
<p>Bit</p>
</td>
</tr>
<tr>
<td width="34%" style="border:1px solid #e1e2e2; padding:5px">
<p>Decimal</p>
</td>
<td width="35%" style="border:1px solid #e1e2e2; padding:5px">
<p>Decimal</p>
</td>
<td width="31%" style="border:1px solid #e1e2e2; padding:5px">
<p>Decimal</p>
</td>
</tr>
<tr>
<td width="34%" style="border:1px solid #e1e2e2; padding:5px">
<p>Decimal</p>
</td>
<td width="35%" style="border:1px solid #e1e2e2; padding:5px">
<p>Money</p>
</td>
<td width="31%" style="border:1px solid #e1e2e2; padding:5px">
<p>Money</p>
</td>
</tr>
<tr>
<td width="34%" style="border:1px solid #e1e2e2; padding:5px">
<p>Decimal</p>
</td>
<td width="35%" style="border:1px solid #e1e2e2; padding:5px">
<p>SmallMoney</p>
</td>
<td width="31%" style="border:1px solid #e1e2e2; padding:5px">
<p>SmallMoney</p>
</td>
</tr>
<tr>
<td width="34%" style="border:1px solid #e1e2e2; padding:5px">
<p>Float</p>
</td>
<td width="35%" style="border:1px solid #e1e2e2; padding:5px">
<p>Float</p>
</td>
<td width="31%" style="border:1px solid #e1e2e2; padding:5px">
<p>Float</p>
</td>
</tr>
<tr>
<td width="34%" style="border:1px solid #e1e2e2; padding:5px">
<p>Guid</p>
</td>
<td width="35%" style="border:1px solid #e1e2e2; padding:5px">
<p>UniqueIdentifier</p>
</td>
<td width="31%" style="border:1px solid #e1e2e2; padding:5px">
<p>Uniqueidentifier</p>
</td>
</tr>
<tr>
<td width="34%" style="border:1px solid #e1e2e2; padding:5px">
<p>Real</p>
</td>
<td width="35%" style="border:1px solid #e1e2e2; padding:5px">
<p>Real</p>
</td>
<td width="31%" style="border:1px solid #e1e2e2; padding:5px">
<p>Real</p>
</td>
</tr>
</tbody>
</table>