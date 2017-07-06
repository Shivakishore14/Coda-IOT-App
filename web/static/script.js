/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function notify(s) {
    $("#notificationArea").html(s);
    $('#notification').slideDown(300).delay(3000).slideUp(300);
}