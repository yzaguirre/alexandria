number
tel
search
color
# combobox

```html
<select name="escala_id" required="required" class="form-control">
<option value="1">ESCALA 1</option>
<option value="2">ESCALA 2</option>
<option value="3">ESCALA 3</option>
</select>
```
# Upload image
<file>

# Number only
https://stackoverflow.com/questions/45072708/contenteditable-allow-numbers-only-for-editing
```javascript
 $("#myeditablediv").keypress(function(e) {
	var x = event.charCode || event.keyCode;
	if (isNaN(String.fromCharCode(e.which)) && x!=46) e.preventDefault();
});
```
