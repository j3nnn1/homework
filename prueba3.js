
//alert('Hola jenni')
/*Selectores Jquery*/
/* tiene los mismos selectores de css */

$(document).ready(function(){ console.log('Listo')

/*$('li#quijote1').click(function(){
                    $('#left').load('noticia1.html');
                    })
$('li#quijote2').click(function(){

                    $('#left').load('noticia2.html');
                    })
$('li#quijote3').click(function(){
                    $('#left').load('noticia3.html');
                    })
//$('div#right' ).css('cursor',  'pointer');
//$('div#right' ).css('cursor',  'pointer');
//*/
        var id= $("li:first").attr('id');
        $('div#left').load(id+".html");

        $('li').click(function(){
            var id = $(this).attr('id');
            $("div#left").load(id+".html")
            $('li[id*=noticia]').css('background-color',  'white');
            $(this).css('background-color', 'green');
        });
});


