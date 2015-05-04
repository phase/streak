function getRandomLine(file){
  fs.readFile(file, function(err, data){
    if(err) throw err;
	var lines = data.split('\n');
	return lines[Math.floor(Math.random()*lines.length)];
  })
}