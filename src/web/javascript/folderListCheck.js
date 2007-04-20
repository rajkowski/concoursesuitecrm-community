function collectValues()
{
    var searchList = document.getElementById("selectedList");
    var listLength = searchList.length;
    var graphListLength = document.fieldDisplay.graphType.length;
    var listValue ="";
    var listText = "";
    var chartType = "";
    var graphId="";
    var totalText = "";
    var totalValue = "";
    var duplicate = false;
    for(k=0; k<graphListLength; k++)
    {
        if(document.fieldDisplay.graphType.options[k].selected)
        {
            graphId = document.fieldDisplay.graphType.options[k].value;
            chartType = document.fieldDisplay.graphType.options[k].text;
        }

    }
    for(i=1; i<size; i++){
        if(document.getElementById('checkelement'+i).checked){
            listValue =  document.getElementById('checkelement'+i).value;
            listText =   document.getElementById('hiddenelement'+i).value;
            if(totalText.length>0){
                listText = totalText+", "+listText;
                listValue = totalValue+", "+listValue;
            }
            totalText = listText;
            totalValue = listValue;
        }
    }
    if(totalText.length > 0 && totalValue.length > 0 &&  chartType.length > 0) {
        listText = totalText+" ("+	chartType + ")";
        listValue = "{"+totalValue+"}:"+graphId;
        for(j=0; j<searchList.length; j++){
            if(searchList.options[j].text == listText){
                duplicate = true;
                break;
            }
        }
        if(duplicate==false){
            searchList.options[searchList.options.length] = new Option(listText, listValue);
        }
        resetCheckBox();
    }else{
        alert("Please select at least one field to add");
    }

}

function resetCheckBox(){
    for(i=1; i<size; i++){
        if(document.getElementById('checkelement'+i).checked){
            document.getElementById('checkelement'+i).checked = false;
        }
    }
}
function removeValues(){
    var searchList = document.getElementById("selectedList");
    if (searchList.length == 0) {
        alert("Nothing to remove");
    } else if (searchList.selectedIndex == -1) {
        alert("An item needs to be selected before it can be removed");
    } else {
        //resetValue();
        while(searchList.length>0){
            searchList.options[searchList.selectedIndex] = null;
        }
    }
    return true;
}
function returnToParent(){
    var searchList = document.getElementById("selectedList");
    var hiddenFieldId = document.getElementById("hiddenFieldId").value;
    var minorAxisParamValues = "";
    for(k=0; k<searchList.length; k++) {
        if(minorAxisParamValues!=null && minorAxisParamValues.length > 0 ){
            minorAxisParamValues = minorAxisParamValues+";"+searchList.options[k].value;
        }else{
            minorAxisParamValues = searchList.options[k].value;
        }
        opener.childToParent(searchList.options[k].text, searchList.options[k].value);
    }
    opener.setMinorAxisValues(minorAxisParamValues, hiddenFieldId);
    window.self.close();
}

function childToParent(popUptext, popUpvalue){
    var minorAxisList =  document.getElementById("minorAxisParam");
    minorAxisList.options[minorAxisList.options.length] = new Option(popUptext, popUpvalue);
}

function setMinorAxisValues(minorAxisValues, hiddenFieldId){
    var minorAxisHiddenField =  document.getElementById(hiddenFieldId);
    minorAxisHiddenField.value= minorAxisValues;
}
function setMajorAxis(hiddenFieldId){
    var selectedValue="";
    for(i=0; i < document.forms[0].majorAxisSelect.length; i++){
        if(document.forms[0].majorAxisSelect[i].checked){
            selectedValue=document.forms[0].majorAxisSelect[i].value;
        }
    }
    document.getElementById(hiddenFieldId).value= selectedValue;
}
function clearValues() {
    if (document.getElementById("minorAxisParam") != null) {
        var minorAxisList = document.getElementById("minorAxisParam");
        while (minorAxisList.length > 0) {
            minorAxisList.options[minorAxisList.options.length - 1] = null;
        }
    }
}

function clearDisplayList() {
    var displayLists =  document.getElementById("displayArea");
    if(displayLists!=null){
        document.getElementById("displayArea").value ="";
    }
}
function resetFormValues(){
    if(document.getElementById("hiddenMajorAxis")!=null && document.getElementById("hiddenMajorAxisDiv")!=null){
        var majorAxisField = document.getElementById("hiddenMajorAxis").value;
        var divToChange = document.getElementById("hiddenMajorAxisDiv").value;
        document.getElementById(majorAxisField).value = -1;
        document.getElementById(divToChange).innerHTML = 'None Selected';
    }
    var minorAxisList =  document.getElementById("minorAxisParam");
    if(minorAxisList!=null && document.getElementById("hiddenMinorAxis")!=null){
        while(minorAxisList.length > 0){
            minorAxisList.options[minorAxisList.options.length-1] =null;
        }
        var minorAxis = document.getElementById("hiddenMinorAxis").value;
        document.getElementById(minorAxis).value = -1
    }
    if(document.getElementById('toChange') != null && document.getElementById("hiddenRangeSelect")!=null) {
        var rangeToChange = document.getElementById('toChange');
        var hiddenRange = document.getElementById('hiddenRangeSelect').value;
        rangeToChange.innerHTML = '12 Records Ago to Current';
        document.getElementById(hiddenRange).value = "Start:Relative,12;End:Relative,0";
    }

    var displayLists =  document.getElementById("displayArea");
    if(displayLists!=null){
        document.getElementById("displayArea").value ="";

    }
}
