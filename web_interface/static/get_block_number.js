setInterval(function() {
    
    $.ajax({
    type: "POST",
    url: "/satellite_demo/get_block_number",
    data: {
	'csrfmiddlewaretoken' : $("input[name=csrfmiddlewaretoken]").val()
    },
    success: blockNumberSuccess,
    dataType: 'html'
    });
    
}, 1000);

function blockNumberSuccess(data, textStatus, jqXHR)
{
    $('#block_number').html(data);
}
