<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It's a breeze. Simply tell Laravel the URIs it should respond to
| and give it the controller to call when that URI is requested.
|
*/

/* Main website page */
Route::get('/', 'PagesController@home')->name('home');
/* Page with reports for a specific finished test */
Route::get('/report/{id}', 'PagesController@report')->name('report');
/* End a given test execution */
Route::get('/kill/{id}', 'PagesController@kill')->name('kill');
/* List with execution state of all tests */
Route::get('/ajax/jobs', 'AjaxController@jobs');
/* List with execution state of all tests */
Route::get('/ajax/status', 'AjaxController@status');
/* Status of the current timed-throughput test */
Route::get('/ajax/tmpTimed/{id}', 'AjaxController@updateTimedThroughput');
/* Test execution request, called from the main page */
Route::post('/execute', 'FormsController@execute');
