$(document).ready(function() {
    console.log('ready');
    init();
});

function init(){
   onshowinfo();
}

function onshowinfo(){
	$('#modalinfo').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget) // Button that triggered the modal
            var nombreplaya = button.data('nombreplaya');
            console.log(nombreplaya);
            console.log("Nombre de la playa arriba");
            var idplaya = button.data('idplaya');
            var modal = $(this);
            modal.find('.modal-body h4').text(nombreplaya);
            $.ajax({
                type: "GET",
                url: "Controller?op=puntuacion&idplaya="+idplaya,
                success : function(info) {
                        $(".modal-body div").html(info);
                }
            })
	})
}