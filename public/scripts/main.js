////////////////// УДАЛЕНИЕ //////////////////

function deleteElement(id, path) {
	var xhr = new XMLHttpRequest();
	xhr.open('DELETE', path + id );
	xhr.onload = () => {
		if (xhr.status === 200) {
							console.log(window.location.protocol + '://' + window.location.host +'/orders/')
			alert(xhr.responseText);
			if (window.location.pathname == '/orders/'+ document.getElementById("hidden_id").value ) {
				window.location.href = '/orders'
			}else {
				location.reload();
			}
		}
		else {
			alert('Произошла ошибка: ' + xhr.responseText);
		}
		console.log(xhr.responseText)
	};
	xhr.send();
}


////////////////// РЕДАКТИРОВАНИЕ //////////////////

[
	[document.getElementById("editPriceListElement"),"/services/"],
	[document.getElementById("editClient"),"/clients/"],
	[document.getElementById("editOrder"),"/orders/"],
	[document.getElementById("add_performed_work"),"/add/performed_work/"]
].forEach((item,index,array)=>{
	if (item[0]!=null) item[0].addEventListener("submit", (event)=>{
		event.preventDefault();
		var xhr = new XMLHttpRequest();
		xhr.onload = () => {
			if (xhr.status === 200) {
				alert(xhr.responseText);
				location.reload();
			}
			else {
				alert('Произошла ошибка: ' + xhr.responseText);
			}
			console.log(xhr.responseText)
		};
		xhr.open ('POST', item[1] + document.getElementById("hidden_id").value , true);
		xhr.send (new FormData (item[0]));
	});
});


////////////////// СОЗДАНИЕ //////////////////

[
	[document.getElementById("createPriceListElement"),"/services/new"],
	[document.getElementById("addClient"),"/clients/new"],
	[document.getElementById("createOrder"),"/orders/new"],
].forEach((item,index,array)=>{
	if (item[0]!=null) item[0].addEventListener("submit", (event)=>{
		event.preventDefault();
		var xhr = new XMLHttpRequest();
		xhr.onload = () => {
			if (xhr.status === 200) {
				alert(xhr.responseText);
				window.location.href = '/'
			}
			else {
				alert('Произошла ошибка: ' + xhr.responseText);
			}
			console.log(xhr.responseText)
		};
		xhr.open ('POST', item[1], true);
		xhr.send (new FormData (item[0]));
	});
});