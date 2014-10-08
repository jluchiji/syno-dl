path = require 'path'

module.exports = (grunt) ->

  # Load grunt tasks
  grunt.loadNpmTasks 'grunt-download-atom-shell'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-shell'

  grunt.file.setBase path.resolve '..'

  # Project configuration
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    'clean':
      build: [
        './dist/app'
      ]
    'download-atom-shell':
      version: '0.17.2'
      outputDir: './dist'
      rebuild: yes
    'coffee':
      build:
        expand: yes
        cwd: './src'
        src: ['**/*.coffee']
        dest: './dist/app/script'
        ext: '.js'
    'less':
      compile:
        expand: yes
        cwd: './static'
        src: ['**/*.less']
        dest: './dist/app/style'
        ext: '.css'
    'copy':
      html:
        expand: yes
        cwd: './static'
        src: ['**/*.html']
        dest: './dist/app/view'
      metadata:
        src: ['package.json']
        dest: './dist/app/package.json'
      js:
        expand: yes
        cwd: './src'
        src: ['**/*.js']
        dest: './dist/app/script'
      css:
        expand: yes
        cwd: './static'
        src: ['**/*.css']
        dest: './dist/app/style'
      components:
        expand: yes
        cwd: './build/bower_components'
        src: ['**/*.*']
        dest: './dist/app/lib'
    'shell':
      options:
        stdout: no
        stderr: yes
      bower:
        command: [
          'cd ./build',
          'pwd',
          'bower install'
        ].join('&&')
      run:
        command: [
          './dist/Atom.app/Contents/MacOS/Atom ./dist/app'
        ].join('&&')

  # Default tasks
  grunt.registerTask 'default',
    ['clean', 'download-atom-shell', 'shell:bower', 'coffee', 'less', 'copy']
  grunt.registerTask 'run',
    ['clean', 'download-atom-shell', 'shell:bower', 'coffee', 'less', 'copy', 'shell:run']
