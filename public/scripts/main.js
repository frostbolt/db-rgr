function deletePriceListElement(id) {
	console.log("Удаление элемента", id)
	var xhr = new XMLHttpRequest();
	xhr.open('DELETE', '/services/' + id );
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
	xhr.send();
}



document.getElementById("editPriceListElement").addEventListener("submit", (event)=>{
	event.preventDefault();
	console.log("Редактирование элемента", document.getElementById("hidden_id").value )
	var xhr = new XMLHttpRequest();
	xhr.onload = () => {
		if (xhr.status === 200) {
			alert(xhr.responseText);
			// location.reload();
		}
		else {
			alert('Произошла ошибка: ' + xhr.responseText);
		}
		console.log(xhr.responseText)
	};
	xhr.open ('POST', '/services/' + document.getElementById("hidden_id").value , true);
	xhr.send (new FormData (document.getElementById("editPriceListElement")));
});
