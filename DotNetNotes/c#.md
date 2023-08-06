---
title:        c#
permalink:    DotNetNotes/c#
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

# Quick tips

## Create Unique Ids

[library](https://github.com/RobThree/IdGen)
[generators](https://github.com/pbolduc/FlakeGen/tree/master/src/FlakeGen)

---

> GUID is 128 bit (16 bytes) data. To convert GUID to integer without data loss, we cannot use Int32 or Int64.

> .NET 4.0 introduced BigInteger struct which is 128 bit integer. And GUID can be easily converted to BigInteger as follows.

```csharp
using System;
using System.Numerics;

class Program
{
    static void Main(string[] args)
    {
        // ex: 8a847645-8cac-422c-962a-fdf3aa220065
        Guid g = Guid.NewGuid();

        // Convert GUID to BigInteger
        // ex: 134252730720501571475137903438348973637
        BigInteger bigInt = new BigInteger(g.ToByteArray());
    }
}
```

---

```csharp
Guid = Guid.NewGuid()
```

---

```csharp
var id64Generator = new Id64Generator();

public string generateID(string sourceUrl)
{
    return string.Format("{0}_{1}", sourceUrl, id64Generator.GenerateId());
}

// node 0
var id64Generator = new Id64Generator(0);

// node 1
var id64Generator = new Id64Generator(1);

// ... node 10
var id64Generator = new Id64Generator(10);
```

---

```csharp
internal static class CorrelationIdGenerator
{
    // Base32 encoding - in ascii sort order for easy text based sorting
    private static readonly char[] s_encode32Chars = "0123456789ABCDEFGHIJKLMNOPQRSTUV".ToCharArray();

    // Seed the _lastConnectionId for this application instance with
    // the number of 100-nanosecond intervals that have elapsed since 12:00:00 midnight, January 1, 0001
    // for a roughly increasing _lastId over restarts
    private static long _lastId = DateTime.UtcNow.Ticks;

    public static string GetNextId() => GenerateId(Interlocked.Increment(ref _lastId));

    private static string GenerateId(long id)
    {
        return string.Create(13, id, (buffer, value) =>
        {
            char[] encode32Chars = s_encode32Chars;

            buffer[12] = encode32Chars[value & 31];
            buffer[11] = encode32Chars[(value >> 5) & 31];
            buffer[10] = encode32Chars[(value >> 10) & 31];
            buffer[9] = encode32Chars[(value >> 15) & 31];
            buffer[8] = encode32Chars[(value >> 20) & 31];
            buffer[7] = encode32Chars[(value >> 25) & 31];
            buffer[6] = encode32Chars[(value >> 30) & 31];
            buffer[5] = encode32Chars[(value >> 35) & 31];
            buffer[4] = encode32Chars[(value >> 40) & 31];
            buffer[3] = encode32Chars[(value >> 45) & 31];
            buffer[2] = encode32Chars[(value >> 50) & 31];
            buffer[1] = encode32Chars[(value >> 55) & 31];
            buffer[0] = encode32Chars[(value >> 60) & 31];
        });
    }
}
```

---

# Looping

## foreach with index

```csharp
foreach ((string msg, int index) in messageStringList.Select((msg, index) => (msg, index)))
	{
		if (!msg.Contains("https:")) continue;
		interactionResponse.output.content.Add(await BuildResponseWithLinks(msg, index, messageStringList));
	}
```

***

# Dictionary

## get properties and values of object

```csharp
Dictionary<string, object> customParams = visitor
                                             .GetType()
                                             .GetProperties(BindingFlags.Instance | BindingFlags.Public)
                                             .ToDictionary(keySelector: prop => prop.Name, elementSelector: prop => prop.GetValue(visitor, index: null));
```

***

# String

## split

```csharp
string[] separatingStrings = { "https://" };
string[] words = msg.Split(separatingStrings, System.StringSplitOptions.RemoveEmptyEntries);
```

## Regex

```csharp
Regex urlPattern = new Regex(@"(?:(?<=\\n|\n|\s\w*)https:\/\/.*?(?<=\s|$))", RegexOptions.Compiled | RegexOptions.IgnorePatternWhitespace | RegexOptions.IgnoreCase);
						MatchCollection matches = urlPattern.Matches(message);

						foreach (Match match in matches) { Console.WriteLine(message.Substring(match.Index, match.Length)); }
```

```csharp
string mystring = "Here are some linked FAQs that might answer that:  \nhttps://dev.veridiancu.org/faq/8107/what-is-an-hsa-health-savings-account and here this \nhttps://dev.veridiancu.org/faq/8108/how-do-i-qualify-for-a-health-savings-account  and here this \nhttps://dev.veridiancu.org/faq/8106/can-i-open-a-cd-on-my-hsa";

System.Text.RegularExpressions.Regex urlPattern = new System.Text.RegularExpressions.Regex(@"(?:(?:\\n|\n|\s\w*)https:\/\/.*?(?:\s|$))", System.Text.RegularExpressions.RegexOptions.Compiled | System.Text.RegularExpressions.RegexOptions.IgnorePatternWhitespace | System.Text.RegularExpressions.RegexOptions.IgnoreCase);

 System.Text.RegularExpressions.MatchCollection matches = urlPattern.Matches( msg);

string[] stringArray = urlPattern.Split(msg);

 string result = urlPattern.Replace(mystring, delegate(System.Text.RegularExpressions.Match m) {
                               System.Text.RegularExpressions.Match urlMatch = System.Text.RegularExpressions.Regex.Match(m.Value, @" 
                                                                                                          (https:\/\/)(.*?)(\s|$)");
                                                                return $"~{urlMatch.Value}~";
                                                             });

   var nn = result.Split('~');
 
``` 

***

# Stream

```csharp
using System;
using System.Threading.Tasks;
using System.Windows;
using System.IO;

namespace WpfApplication
{
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private async void Button_Click(object sender, RoutedEventArgs e)
        {
            string StartDirectory = @"c:\Users\exampleuser\start";
            string EndDirectory = @"c:\Users\exampleuser\end";

            foreach (string filename in Directory.EnumerateFiles(StartDirectory))
            {
                using (FileStream SourceStream = File.Open(filename, FileMode.Open))
                {
                    using (FileStream DestinationStream = File.Create(EndDirectory + filename.Substring(filename.LastIndexOf('\\'))))
                    {
                        await SourceStream.CopyToAsync(DestinationStream);
                    }
                }
            }
        }
    }
}
```

---

# Text Writer

```csharp
using System.IO;

namespace ConsoleApplication
{
    class Program4
    {
        static void Main()
        {
            WriteCharacters();
        }

        static async void WriteCharacters()
        {
            using (StreamWriter writer = File.CreateText("newfile.txt"))
            {
                await writer.WriteLineAsync("First line of example");
                await writer.WriteLineAsync("and second line");
            }
        }
    }
}
```

***

# File & Directory

```csharp
string currentDir = Directory.GetCurrentDirectory();
string path = Path.Combine(new FileInfo(Assembly.GetExecutingAssembly().Location).DirectoryName,"vcu-chat-bot");
FileStream stream = new(path, FileMode.Open, FileAccess.Read);
```

***

# Email & SMS

## use GMail as SMTP Server

> GMail accounts can actually be used as an SMTP server, in a manner of speaking. That’s exactly what we need – a way of sending an email to the mobile phone carrier, so they can in turn send a text message to the mobile phone. We send the email to GMail, GMail passes it on to the mobile phone carrier, which turns it into a text message and sends it to our cell phone. Yes, it does involve a few steps, but you can’t argue against the price (free!).

> The SMTP server functionality isn’t exactly available for anyone to get access to – you have to have a GMail account (which is free). Because of this we will need to do a few special things. More on that later though. Let’s see how it’s done.

> Here’s a code snippet on how to do it. First of all, in our Windows App, we need to include the following “using” statements:

```csharp
using System.Net;
using System.Net.Mail;
```

> Somewhere in the body of the program, we need to create a new MailMessage, give it some details, like so:

```csharp
MailMessage message = new MailMessage();
message.To.Add("1234567890@txt.bell.ca");
message.From = new MailAddress("yourgmailaccount@gmail.com", "App"); //See the note afterwards...
message.Body = "This is your cell phone. How was your day?";
```

> At this point the email address that the message comes from really doesn’t matter – it won’t show up as GMail will override it when it gets passed on to the mobile phone carrier. The important one to get right is the email address that it is going to be sent to. This depends on your phone number and your mobile carrier. In this case, the phone number is (123)456-7890 and the carrier is Bell. Check out the previously mentioned wikipedia link to see what your carrier specific email address is.
> If you don’t get this right, the message will most certainly not get through.

> Next, we need to create an SMTP client, and set it up:

```csharp
SmtpClient smtp = new SmtpClient("smtp.gmail.com");
smtp.EnableSsl = true;
smtp.Port = 587;
smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
smtp.Credentials = new NetworkCredential("yourgmailaddress@gmail.com", "yourgmailpassword");
```

> Here we create a new SMTP Client that will connect to the GMail SMTP server. Because we are connecting to a GMail secured server we need to enable SSL, as well as use a particular port – port 587. (There is apparently another port that can be used, but I haven’t heard of anyone getting it to work – port 465). Next, you need to put your own GMail email address where “yourgmailaddress.gmail.com” is, as well as replace “yourgmailpassword” with your actual GMail password.

> After this, there isn’t much you need to do – send the email, like so:

```csharp
try
{
smtp.Send(message);

}
catch (Exception ex)
{
MessageBox.Show(ex.Message);
}
```

## SMS

### sms with email

> Most major carriers offer an email to text service. The program can use email to send an SMS message. For example:

```csharp
var message = new MailMessage();
message.From = new MailAddress("sender@foo.bar.com");

message.To.Add(new MailAddress("5551234567@txt.att.net"));//See carrier destinations below
//message.To.Add(new MailAddress("5551234568@txt.att.net"));

//message.CC.Add(new MailAddress("carboncopy@foo.bar.com"));
message.Subject = "This is my subject";
message.Body = "This is the content";

var client = new SmtpClient();
client.Send(message);
```

### Carrier destinations

- ATT: Compose a new email and use the recipient's 10-digit wireless phone number, followed by @txt.att.net. For example, 5551234567@txt.att.net.
- Verizon: Similarly, ##@vtext.com
- Sprint: ##@messaging.sprintpcs.com
- TMobile: ##@tmomail.net
- Virgin Mobile: ##@vmobl.com
- Nextel: ##@messaging.nextel.com
- Boost: ##@myboostmobile.com
- Alltel: ##@message.alltel.com
- EE: ##@mms.ee.co.uk (might support send without reply-to)

<html>
<body>
<!--StartFragment--><br class="Apple-interchange-newline">

 Mobile carrier            | SMS gateway domain      | MMS gateway domain 
---------------------------|-------------------------|--------------------
 sms.alltelwireless.com    | mms.alltelwireless.com  
 txt.att.net               | mms.att.net             
 sms.myboostmobile.com     | myboostmobile.com       
 mailmymobile.net          | mailmymobile.net        
 mms.cricketwireless.com   | mms.cricketwireless.com 
 msg.fi.google.com         | msg.fi.google.com       
 mymetropcs.com            | mymetropcs.com          
 text.republicwireless.com | messaging.sprintpcs.com | pm.sprint.com      
 tmomail.net               | tmomail.net             
 message.ting.com          | email.uscc.net          | mms.uscc.net       
 vtext.com                 | vzwpix.com              
 vmobl.com                 | vmpix.com               
 vtext.com                 | mypixmessages.com       

| Mobile carrier                                                                                                                                 | SMS gateway domain        | MMS gateway domain      |
|------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------|-------------------------|
| [Alltel](https://en.wikipedia.org/wiki/Alltel)[[1]](https://en.wikipedia.org/wiki/SMS_gateway#cite_note-Pot2016-1)                             | sms.alltelwireless.com    | mms.alltelwireless.com  |
| [AT&T](https://en.wikipedia.org/wiki/AT%26T_Mobility)[[2]](https://en.wikipedia.org/wiki/SMS_gateway#cite_note-ATT-2)                          | txt.att.net               | mms.att.net             |
| [Boost Mobile](https://en.wikipedia.org/wiki/Boost_Mobile_(United_States))[[1]](https://en.wikipedia.org/wiki/SMS_gateway#cite_note-Pot2016-1) | sms.myboostmobile.com     | myboostmobile.com       |
| [Consumer Cellular](https://en.wikipedia.org/wiki/Consumer_Cellular)[[3]](https://en.wikipedia.org/wiki/SMS_gateway#cite_note-:0-3)            | mailmymobile.net          | mailmymobile.net        |
| [Cricket Wireless](https://en.wikipedia.org/wiki/Cricket_Wireless)                                                                             | mms.cricketwireless.com   | mms.cricketwireless.com |
| [Google Fi Wireless](https://en.wikipedia.org/wiki/Google_Fi_Wireless)[[4]](https://en.wikipedia.org/wiki/SMS_gateway#cite_note-Esparza2016-4) | msg.fi.google.com         | msg.fi.google.com       |
| [MetroPCS](https://en.wikipedia.org/wiki/MetroPCS)                                                                                             | mymetropcs.com            | mymetropcs.com          |
| [Republic Wireless](https://en.wikipedia.org/wiki/Republic_Wireless)[[5]](https://en.wikipedia.org/wiki/SMS_gateway#cite_note-5)               | text.republicwireless.com | na                      |
| [Sprint](https://en.wikipedia.org/wiki/Sprint_Corporation)[[1]](https://en.wikipedia.org/wiki/SMS_gateway#cite_note-Pot2016-1)                 | messaging.sprintpcs.com   | pm.sprint.com           |