<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<script language="javascript">
  var thisContactId = -1;
  var thisCallId = -1;
  var menu_init = false;
  //Set the action parameters for clicked item
  function displayMenu(id, contactId, callId) {
    thisContactId = contactId;
    thisCallId = callId;
    if (!menu_init) {
      menu_init = true;
      new ypSlideOutMenu("menuCall", "down", 0, 0, 170, getHeight("menuCallTable"));
    }
    return ypSlideOutMenu.displayMenu(id);
  }
  //Menu link functions
  function details() {
    window.location.href='AccountContactsCalls.do?command=Details&contactId=' + thisContactId + '&id=' + thisCallId;
  }
  
  function modify() {
    window.location.href='AccountContactsCalls.do?command=Modify&contactId=' + thisContactId + '&id=' + thisCallId + '&return=list';
  }
  
  function forward() {
    window.location.href='AccountContactsCalls.do?command=ForwardCall&contactId=' + thisContactId + '&id=' + thisCallId + '&return=list';
  }
  
  function deleteCall() {
    popURL('AccountContactsCalls.do?command=ConfirmDelete&id=' + thisCallId + '&contactId=' + thisContactId + '&popup=true' + '<%= addLinkParams(request, "popupType|actionId") %>', 'CONFIRM_DELETE','320','200','yes','no');
  }
</script>
<div id="menuCallContainer" class="menu">
  <div id="menuCallContent">
    <table id="menuCallTable" class="pulldown" width="170">
      <dhv:permission name="accounts-accounts-contacts-calls-view">
      <tr>
        <td>
          <img src="images/icons/stock_zoom-page-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </td>
        <td width="100%">
          <a href="javascript:details()">View Details</a>
        </td>
      </tr>
      </dhv:permission>
      <dhv:permission name="accounts-accounts-contacts-calls-edit">
      <tr>
        <td>
          <img src="images/icons/stock_edit-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </td>
        <td width="100%">
          <a href="javascript:modify()">Modify</a>
        </td>
      </tr>
      </dhv:permission>
      <dhv:permission name="accounts-accounts-contacts-calls-view">
      <tr>
        <td>
          &nbsp;
        </td>
        <td width="100%">
          <a href="javascript:forward()">Forward</a>
        </td>
      </tr>
      </dhv:permission>
      <dhv:permission name="accounts-accounts-contacts-calls-delete">
      <tr>
        <td>
          <img src="images/icons/stock_delete-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </td>
        <td width="100%">
          <a href="javascript:deleteCall()">Delete</a>
        </td>
      </tr>
      </dhv:permission>
    </table>
  </div>
</div>