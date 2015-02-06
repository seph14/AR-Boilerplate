var gulp = require('gulp');
var spritesmith = require('gulp.spritesmith');
/*
https://github.com/twolfson/gulp.spritesmith
*/
gulp.task('sprite', function () {
  var spriteData = gulp.src('src/img.sprite.src/*.png').pipe(spritesmith({
    imgName: 'sprite.png',
    cssName: 'sprite.styl'
  }));
  spriteData.pipe(gulp.dest('static/'));
});