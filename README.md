# split-it-all

It was a dark and stormy night. In a room humid with sweat, temperature reached 29°C. The night slipped from 3rd to 4th, it was March of 2022, Friday. I had school the other day, and yet, I was up all night trying to extract images from this japanese VN.

This was a curious case. After somehow extracting the the files from this absurd `.arc` format, I was at a loss. Each animations, as it seemed, was a long image file with each animation frame placed side to side. Each frame measuring `960 pixels` width.
I wanted those animations bad. But  manually cutting up each frame perfectly was near about impossible. So, I did what every self proclaimed programmer would. I considered automating it all with code.

## The Journey (not worth reading. this is a note to self)
This project is a culmination of a lot of things. Call it stubbornness, or overconfidence, I was sure it was just a matter of an hour. "1 or 2 am at most", I thought, and having compiled a few scripts in Autoit before, I got started.

🔴 Batch files are used for automation. Maybe I can write something up? (I knew 0 thing about batch scripting)

🟠 Batch files support drag n' drop. I need drag n' drop. Ok. No more Autoit then.

🟡 But then how do it split it? Batch files cannot process image. I need something else

🟢 Okay, I found this split-image project on github. How do I use it? Ooooooo it's in python (All I know about Python is that it's procedure oriented)

🔵 Fine I can pass some arguments into it's cli via the batch file.

🟣 So I have to mention the number of splits I want, but... batch files can't process image. I need to read the image width, and find the number of splits. And, I can't write python 🥲

🟤 Well, Autoit it is then. I should read the image, find possible splits, and then pass that information to the batch file which will then pass that to split.py

⚫ BUT how do I pass data between autoit and batch file? * an hour of brute force later* FINE text file it is.

⚪ So there I was. Hours in and a project with a million pieces.


## How it works

1. User Drag n' Drops an image to `START.bat`
<p align="center">
<img width="334" alt="Drop file in START.bat" src="https://user-images.githubusercontent.com/64971616/229288493-6df378ff-cc31-4a60-9f28-b8814cb2162a.png">
</p>

2. `STRAT.bat` renames the file to replace space with underscore (Space causes issues while handling image in autoit). And passes it to `split.bat`.
<p align="center">
<img width="312" alt="Pass renamed image to split.bat" src="https://user-images.githubusercontent.com/64971616/229288763-73675e20-46dc-4b30-81d5-cc56012a9316.png">
</p>

3. `split.bat` creates a new folder with the same name as the image, and moves the image into that folder.
<p align="center">
<img width="336" alt="split.bat moves image to folder" src="https://user-images.githubusercontent.com/64971616/229288872-dc4ab8f4-1517-44f7-8120-9bfb7884ccd6.png">
</p>

4. `split.bat` creates a text file and writes the address of the image to the first line.
<p align="center">
<img width="377" alt="split.bat creates text file with address of the image" src="https://user-images.githubusercontent.com/64971616/229288972-89409c3b-cfcc-475c-809b-2d56663c451f.png">
</p>

5. `split.bat` starts `width.au3` (or .exe).
<p align="center">
<img width="350" alt="split.bat starts width.au3" src="https://user-images.githubusercontent.com/64971616/229289104-fdd06091-d5b8-4823-933a-e1f036faab09.png">
</p>

6. `width.au3` reads the text file to get the location of the image. It then calculates the number of horizontal splits it can perform based on the split width hardcoded in the script. It then writes that number in the first line of the text file.
<p align="center">
<img width="272" alt="calculating possible splits" src="https://user-images.githubusercontent.com/64971616/229289488-6095f86c-0148-48e5-96b6-b3e433184351.png">
<br/>Vertical splits are NOT performed as it was not required for my use case.<br/>
<br/><img width="333" alt="width.au3 writes the number of possible splits to the text file" src="https://user-images.githubusercontent.com/64971616/229289457-48841405-05c9-47a7-811d-566bc294a9d3.png">
</p>

7. `split.bat` then takes both, the image and the possible split integer, and passes it to `split.py`.
<p align="center">
<img width="321" alt="split.bat passes all information to split.py" src="https://user-images.githubusercontent.com/64971616/229290110-df5b326e-f29d-4864-9aa0-803ec3bd0641.png">
</p>

8. `split.py` can perform both horizontal and vertical splitting. Bases on requirement, it horizontally splits the image.
<p align="center">
<img width="382" alt="Images are split and placed in folder" src="https://user-images.githubusercontent.com/64971616/229290129-3c2afcff-895a-4560-a008-80ebcada4137.png">
</p>

9. The results are present in a folder as the same name as the imput image, just with underscores in place of spaces.
<p align="center">
<img width="333" alt="Output" src="https://user-images.githubusercontent.com/64971616/229291022-265f9c72-0669-4b59-8cd1-88c3b261fd05.png">
</p>


## Algorithm flow
<table align="center">
<tr>
<th><p align="center">
<br/><img width="352" alt="Screenshot 2023-04-01 183234" src="https://user-images.githubusercontent.com/64971616/229291070-74e2a630-490a-490c-8b44-eed44c508e8e.png">
</p></th>

<th align="left">

1. Input image drag n' drop.

2. Renamed file location paased.

3. Passed new folder location through a text file.

4. Returned split count through the text file.

5. Passed image location and split count.

6. Output files generated.

</th>
</tr>
</table>

## Run/Compile from source
 
> ***By default the size of each horizontal split is 960 pixel***

`Run :` You'll need [Autoit](https://www.autoitscript.com/site/autoit/downloads/) runtime and [Python](https://www.python.org/downloads/) installed to use the scripts directly from code. Drag and drop the require image to `START.bat` to use it. Launching the batch files directly do nothing.

`Compile :` *Autoit* provides a direct tool to convert to .exe and you may use *pyinstaller* to convert the python script to an .exe as well. The batch files run directly.

**NOTE:** I feel like I need to say it every time, but Windows likes to flag almost everything I write as virus. No I am not a malware author. The code is open for you to inspect. Yes, it is a false positive. Yes, it's probably because I don't have a digital certificate.


## Released Packages

The package present in the release contains all the scripts in a runnable format, i.e. as `.exe` or `.bat`.
> ***`width.exe` has hard coded size of horizontal split set to 960 pixel***

and you cannot change that from the execuatble. If you plan to use it for other sizes, I recommend downloading and recompiling `width.au3` with your own custom width value.

<p align="center">
 
 ![in-action](https://user-images.githubusercontent.com/64971616/229310834-c90cdcd0-07d0-4e4f-9ff3-218a5e07a646.gif)
</p>


