module.exports = (grunt) ->

  # Project configuration
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    'download-atom-shell':
      version: '0.17.2'
      outputDir: './build'
      rebuild: yes
    'coffee':
      debug:
        expand: yes
        cwd: './src'
        src: ['*.coffee']
        dest: './build/app'
        ext: '.js'
      release:
        expand: yes
        cwd: './src'
        src: ['*.coffee']
        dest: './build/app'
        ext: '.js'
    'copy':
      expand: yes
      cwd: './src'
      src: ['**/*.html']
      dest: './build/app'

  # Load grunt tasks
  grunt.loadNpmTasks 'grunt-download-atom-shell'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-copy'

  # Default tasks
  grunt.registerTask 'default', ['download-atom-shell', 'coffee:debug', 'copy']
  grunt.registerTask 'release', ['download-atom-shell', 'coffee:release', 'copy']
