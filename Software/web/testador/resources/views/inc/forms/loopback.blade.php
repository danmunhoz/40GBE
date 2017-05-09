
                <div class="col-md-12" id="form_loopback">
                    <div>
                    	<div class="row">
                    		<div class="col-md-6">
								<input class="form-control" type="text" name="sfp[{{ $sfp }}][loopback_mac_source]">
							</div>
                    		<div class="col-md-6">
	                            <select class="form-control" name="sfp[{{ $sfp }}][mac_filter]">
	                                <option value="0">Filter and mirror</option>
	                                <option value="1">Filter and no mirror</option>
	                                <option value="2">Promiscous and mirror</option>
	                                <option value="3">Promiscous and no mirror</option>
	                            </select>
							</div>
						</div>
                    </div>
                </div>