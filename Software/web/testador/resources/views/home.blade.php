@extends('inc.layout')
@section('body')

    @include('inc.navigator')

    <div class="container">
        <div class="container">
            <div class="page-header">
                <div class="row">
                    <div class="col-md-12">
                        <h1>Test setup <small>select and configure the desired tests</small></h1></div>
                </div>
            </div>
        <div class="row">
            <div class="col-md-9">
                <form method="POST" action="{{ url('execute') }}">
                    <input type="hidden" name="_token" value="{{ csrf_token() }}">
            	    @include('inc.forms.sfp', ['sfp' => '1'])
            	    <hr>
            	    @include('inc.forms.sfp', ['sfp' => '2'])
            	    <hr>
            	    @include('inc.forms.sfp', ['sfp' => '3'])
            	    <hr>
            	    @include('inc.forms.sfp', ['sfp' => '4'])
            	    <hr>

                    <div class="row">
                        <div class="col-md-2 col-md-offset-10">
                            <button class="btn btn-default active" type="submit" id="submit">SUBMIT </button>
                        </div>
                    </div>
                </form>
            </div>
            @include('inc.jobs')

        </div>
    </div>
@endsection
