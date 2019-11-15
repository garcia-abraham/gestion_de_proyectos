document.addEventListener("turbolinks:load", function() {
    var burger = document.querySelector('.burger');
    var menu = document.querySelector('#navbarBurger');

    burger.addEventListener('click', function() {
        burger.classList.toggle('is-active');
        menu.classList.toggle('is-active');
    });


    /* notification */
    var notificationIn = document.getElementById("notificationIn");
    if(notificationIn != null){
        hideAlert(notificationIn);
    }
})

function hideAlert(notiIn){
    notiIn.style.marginTop="0px";
    setTimeout(function(){
        notiIn.style.marginTop="-50px";
    }, 3000);
}
