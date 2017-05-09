        
        <div class="row sfp">
            <div class="col-md-12">
                <h2>Channel {{ $sfp }} </h2></div>
            <div class="col-md-4">
                <select class="form-control" name="sfp[{{ $sfp }}][test_selector]">
                    <option value="">Select the Execution</option>
                    <option value="1">RFC2544</option>
                    <option value="2">Timed-throughput</option>
                    <option value="3">Loopback</option>
                </select>
            </div>
            <div class="col-md-1 col-md-offset-7">
                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="sfp[{{ $sfp }}][scheduled]">Run</label>
                </div>
            </div>
            <div class="clearfix"></div>
            @include('inc.forms.rfc2544', ['sfp' => $sfp])
            @include('inc.forms.timed_throughput', ['sfp' => $sfp])
            @include('inc.forms.loopback', ['sfp' => $sfp])
        </div>
