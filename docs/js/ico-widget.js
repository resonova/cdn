/* Configs */
const apiUrl = "https://buy.envilope.com/api/v1/ico/tier/list?year=2018";
const walletAddress = "0x85923a2377e52dda7e9e5c5344861cad27b3e8a1";
const etherScanLink = "https://etherscan.io/token/" + walletAddress;
const minCapPlaceholder = 100;
const maxCapPlaceholder = 2000;
/* Main */
const widgetWrapper = document.querySelector("#scs-ico-wrapper"); //Widget wrapper placed anywhere on page with shortcode.
let xhr = new XMLHttpRequest();
xhr.open("GET", apiUrl, true);
xhr.send();
/* Second block - smart contract address */
const smartContractAddressBox = document.createElement('div');
smartContractAddressBox.classList.add('scs--smart-contract-address--wrapper');
widgetWrapper.appendChild(smartContractAddressBox);
const smartContractAddressTitle = document.createElement('h3');
smartContractAddressTitle.classList.add('scs--smart-contract-address--title');
smartContractAddressTitle.innerText = 'Smart Contract Address'; // You can change this line
smartContractAddressBox.appendChild(smartContractAddressTitle);
const smartContractAddressValue = document.createElement('a');
smartContractAddressValue.classList.add('scs--smart-contract-address--value');
smartContractAddressValue.setAttribute('href', etherScanLink);
smartContractAddressValue.setAttribute('target', '_blank');
smartContractAddressValue.innerText = walletAddress;
smartContractAddressBox.appendChild(smartContractAddressValue);
/* Raised so far block */
const raisedSoFarBox = document.createElement('div');
raisedSoFarBox.classList.add('scs--raised-so-far--wrapper');
widgetWrapper.appendChild(raisedSoFarBox);
const raisedSoFarTitle = document.createElement('h3');
raisedSoFarTitle.classList.add('scs--raised-so-far--title');
raisedSoFarTitle.innerText = 'Raised so far';
raisedSoFarBox.appendChild(raisedSoFarTitle);
const raisedSoFarProgressBarWrapper = document.createElement('div');
raisedSoFarProgressBarWrapper.classList.add('scs--raised-so-far--progressbar--wrapper');
const raisedSoFarProgressBarLabel = document.createElement('div');
raisedSoFarProgressBarLabel.classList.add('scs--raised-so-far--progressbar--label');
raisedSoFarProgressBarLabel.innerText = "1500 ETH";
raisedSoFarProgressBarWrapper.appendChild(raisedSoFarProgressBarLabel);
const raisedSoFarProgressBarValue = document.createElement('div');
raisedSoFarProgressBarValue.classList.add('scs--raised-so-far--progressbar--value');
raisedSoFarProgressBarValue.style.width = '30%';
raisedSoFarProgressBarWrapper.appendChild(raisedSoFarProgressBarValue);
raisedSoFarBox.appendChild(raisedSoFarProgressBarWrapper);
/* Time since ICO start and when it will end */
const timeLineWrapper = document.createElement('div');
timeLineWrapper.classList.add('scs--timeline--wrapper');
const timeLineCounter = document.createElement('span');
timeLineCounter.classList.add('scs--timeline--counter');
timeLineCounter.innerText = '05:05:05:05';
timeLineWrapper.appendChild(timeLineCounter);
const timeLineEndLabel = document.createElement('p');
timeLineEndLabel.classList.add('scs--timeline--end');
timeLineEndLabel.innerText = "The ICO will end ";
const timeLineEndLabelDate = document.createElement('strong');
timeLineEndLabelDate.innerText = 'Nov 18, 2017 5:13 PM';
timeLineEndLabel.appendChild(timeLineEndLabelDate);
timeLineWrapper.appendChild(timeLineEndLabel);
widgetWrapper.appendChild(timeLineWrapper);
/* Additional info */
const addInfoWrapper = document.createElement('div');
addInfoWrapper.classList.add('scs--addinfo--wrapper');
const addInfoTitle = document.createElement('h3');
addInfoTitle.classList.add('scs--addinfo--title');
addInfoTitle.innerText = "Additional info";
addInfoWrapper.appendChild(addInfoTitle);
const minCap = document.createElement('p');
minCap.innerText = "Min cap: ";
const minCapValue = document.createElement('strong');
minCapValue.innerText = minCapPlaceholder + " ETH";
minCap.appendChild(minCapValue);
addInfoWrapper.appendChild(minCap);
const maxCap = document.createElement('p');
maxCap.innerText = "Max cap: ";
const maxCapValue = document.createElement('strong');
maxCapValue.innerText = maxCapPlaceholder + " ETH";
maxCap.appendChild(maxCapValue);
addInfoWrapper.appendChild(maxCap);
widgetWrapper.appendChild(addInfoWrapper);
/* Filling data fields */
xhr.onreadystatechange = function () {
    if (xhr.readyState != 4) return;
    if (xhr.status != 200) {
        console.log(xhr.status + ': ' + xhr.statusText);
    } else {
        let data = JSON.parse(xhr.responseText);
        console.log(data);
        let totalTokenTurnoverSum = 0.00;
        let totalTokenTurnoverAmount = 0;
        let lastData = false;
        for (let i of data) {
            console.log(i);
            if (!lastData || i['dayOfYear'] > lastData['dayOfYear']) {
                lastData = i;
            }
            totalTokenTurnoverSum += i['tokenTurnoverSum'];
            totalTokenTurnoverAmount += i['tokenTurnoverAmount'];
        }
        console.log(totalTokenTurnoverSum);
        console.log(totalTokenTurnoverAmount);
        let tar = parseFloat(lastData['tier']['totalTierSum']);
        let perc = Math.floor(parseFloat(totalTokenTurnoverSum) / parseFloat(tar) * 100);
        raisedSoFarProgressBarValue.style.width = perc + "%";
        raisedSoFarProgressBarLabel.innerText = parseInt(totalTokenTurnoverSum) + " ETH";
        timeLineBegin = lastData['tier']['timelineBegin'];
        console.log(timeLineBegin);
        timeLineEnd = lastData['tier']['timelineEnd'];
        timeLineEndLabelDate.innerText = new Date(timeLineEnd[0], timeLineEnd[1] - 1, timeLineEnd[2], timeLineEnd[3], timeLineEnd[4]).toLocaleString('en-US', {
            month: 'short',
            day: 'numeric',
            year: 'numeric',
            hour: 'numeric',
            minute: '2-digit',
            hour12: true
        });
        timeBegin = new Date(timeLineBegin[0], timeLineBegin[1] - 1, timeLineBegin[2], timeLineEnd[3], timeLineEnd[4]);
        now = new Date();
        diff = now.getTime() - timeBegin.getTime();
        var dd = Math.floor(diff / 1000 / 60 / 60 / 24);
        diff -= dd * 1000 * 60 * 60 * 24;
        var hh = Math.floor(diff / 1000 / 60 / 60);
        diff -= hh * 1000 * 60 * 60;
        var mm = Math.floor(diff / 1000 / 60);
        diff -= mm * 1000 * 60;
        var ss = Math.floor(diff / 1000);
        if (hh < 10) {
            hh = "0" + hh;
        }
        if (mm < 10) {
            mm = "0" + mm;
        }
        if (ss < 10) {
            ss = "0" + ss;
        }
        timeLineCounterText = dd + ":" + hh + ":" + mm + ":" + ss;
        timeLineCounter.innerText = timeLineCounterText;
        setInterval(() => {
            txtSplit = timeLineCounterText.split(":");
            if (parseInt(txtSplit[3]) == 59) {
                txtSplit[3] = "00";
                if (parseInt(txtSplit[2]) == 59) {
                    txtSplit[2] = "00";
                    if (parseInt(txtSplit[1]) == 23) {
                        txtSplit[1] = "00";
                        txtSplit[0] = parseInt(txtSplit[0]) + 1;
                    } else if (parseInt(txtSplit[1]) + 1 < 10) {
                        txtSplit[1] = "0" + (parseInt(txtSplit[1]) + 1);
                    } else {
                        txtSplit[1] = parseInt(txtSplit[1]) + 1;
                    }
                } else if (parseInt(txtSplit[2]) + 1 < 10) {
                    txtSplit[2] = "0" + (parseInt(txtSplit[2]) + 1);
                } else {
                    txtSplit[2] = parseInt(txtSplit[2]) + 1;
                }
            } else if (parseInt(txtSplit[3]) + 1 < 10) {
                txtSplit[3] = "0" + (parseInt(txtSplit[3]) + 1);
            } else {
                txtSplit[3] = parseInt(txtSplit[3]) + 1;
            }
            timeLineCounterText = txtSplit.join(":");
            timeLineCounter.innerText = timeLineCounterText;
        }, 1000);
    }
}
