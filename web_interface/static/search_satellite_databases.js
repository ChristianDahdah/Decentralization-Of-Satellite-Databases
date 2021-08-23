$(function(){

	$('#search_databases').click(function() {

		$.ajax({
			type: "POST",
			url: "/satellite_demo/search_satellite_databases",
			data: { 
			'satellite_id' : $('#satellite_id').val(),
			'csrfmiddlewaretoken' : $("input[name=csrfmiddlewaretoken]").val()
			},
			success: searchSuccess,
			dataType: 'html'
		});

	});

});


function searchSuccess(data, textStatus, jqXHR)
{
    $('#satellite_databases').html(data);
}
