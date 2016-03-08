var gulp  = require('gulp'),
    ts    = require('gulp-typescript'),
    sourcemaps = require('gulp-sourcemaps');

var projectConfig = {
  noExternalResolve: false,
  "target": "ES5",
  "module": "system",
  "moduleResolution": "node",
  "emitDecoratorMetadata": true,
  "experimentalDecorators": true,
  "removeComments": false,
  "noImplicitAny": false
};


gulp.task('compile_source', function() {
  var tsProject = ts.createProject(projectConfig);
  gulp.src('public/ng2/**/*.ts')
    .pipe(sourcemaps.init())
    .pipe(ts(tsProject))
    .js
    .pipe(sourcemaps.write())
    .pipe(gulp.dest('public/assets/ng2'));
});

gulp.task('watch', ['compile_source'], function() {
  gulp.watch('public/ng2/**/*.ts', ['compile_source']);
});
