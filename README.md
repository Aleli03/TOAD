<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>TOAD experiment data set</title>
    <style>
        table,
        td,
        th {
            border: 1px solid #ddd;
            text-align: left;
        }

        table {
            border-collapse: collapse;
            width: 100%;
        }

        th,
        td {
            padding: 15px;
        }
    </style>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
</head>

<body>
    <div class="w3-sidebar w3-bar-block w3-black w3-card" style="width:130px">
        <button class="w3-bar-item w3-button tablink" onclick="openLink(event, 'How to')">How to</button>
        <button class="w3-bar-item w3-button tablink" onclick="openLink(event, 'Replication study')">Replication
            study</button>
        <button class="w3-bar-item w3-button tablink" onclick="openLink(event, 'Controlled experiment')">Controlled
            experiment</button>
    </div>

    <div style="margin-left:130px">
        If you can't find all the videos here, please try this link:
        <a href="https://drive.google.com/drive/folders/1JNflbSneVxwkhW9cx2-LuLveDpRudsqJ?usp=sharing"> Videos <a />
            <div id="How to" class="w3-container city w3-animate-left" style="display:none">
                <h2>How to use the tool</h2>
                <p>London is the capital city of England.</p>
                <p>It is the most populous city in the United Kingdom, with a metropolitan area of over 13 million
                    inhabitants.</p>
            </div>

            <div id="Replication study" class="w3-container city w3-animate-right" style="display:none">
                <h2>Replication study</h2>
                <h1>TOAD experiment data set</h1>
                <table>
                    <tr>
                        <th>Participant</th>
                        <th>Number of attempts</th>
                        <th>Total attempts changed as expected</th>
                    </tr>
                    <tr>
                        <td>P1</td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>P2</td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>P3</td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>P4</td>
                        <td></td>
                        <td></td>
                    </tr>
                </table>
            </div>

            <div id="Controlled experiment" class="w3-container city w3-animate-left" style="display:none">
                <h2>Controlled experiment</h2>
                <p>London is the capital city of England.</p>
                <p>It is the most populous city in the United Kingdom, with a metropolitan area of over 13 million
                    inhabitants.</p>
            </div>

    </div>


    <script>
        function openLink(evt, animName) {
            var i, x, tablinks;
            x = document.getElementsByClassName("city");
            for (i = 0; i < x.length; i++) {
                x[i].style.display = "none";
            }
            tablinks = document.getElementsByClassName("tablink");
            for (i = 0; i < x.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" w3-red", "");
            }
            document.getElementById(animName).style.display = "block";
            evt.currentTarget.className += " w3-red";
        }
    </script>
</body>

</html>