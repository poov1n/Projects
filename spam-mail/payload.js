<script src ="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	
	$('button').click(function(e){
		e.preventDefault()

		auth = $('input[type=password]').val()
		
		$.post(
			"http://localhost:5000/auth",
				{"password":auth},
				function(data,status){
					window.location = "http://localhost:5000/login"
					}
			);
		return false
	})
</script>
