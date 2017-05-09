
                <div class="col-md-12" id="form_rfc">
                    <div>
                        <div class="col-md-3 col-sm-3">
                            <h4>Tests </h4>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="sfp[{{ $sfp }}][throughput]" checked=""><strong>Throughput</strong></label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="sfp[{{ $sfp }}][latency]" checked=""><strong>Latency</strong></label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="sfp[{{ $sfp }}][loss_rate]" checked=""><strong>Loss-rate</strong></label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="sfp[{{ $sfp }}][back_to_back]" checked=""><strong>Back-to-back</strong></label>
                            </div>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox" name="sfp[{{ $sfp }}][system_recovery]" checked=""><strong>System-recovery</strong></label>
                            </div>
                        </div>
                        <div class="col-md-6 col-sm-9">
                            <div class="row packet_sizes">
                                <div class="col-md-12 col-sm-12">
                                    <div class="row">
                                        <div class="col-md-6 col-sm-6">
                                            <h4>Select Packet Sizes</h4></div>
                                        <div class="col-md-6 col-sm-6">
                                            <div class="checkbox">
                                                <label>
                                                    <input type="checkbox" name="ALL_PACKET_SIZES" checked="">All Sizes</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 col-sm-6">
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="sfp[{{ $sfp }}][ps64]" checked="">64 Bytes</label>
                                    </div>
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="sfp[{{ $sfp }}][ps128]" checked="">128 Bytes</label>
                                    </div>
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="sfp[{{ $sfp }}][ps256]" checked="">256 Bytes</label>
                                    </div>
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="sfp[{{ $sfp }}][ps512]" checked="">512 Bytes</label>
                                    </div>
                                </div>
                                <div class="col-md-6 col-sm-6">
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="sfp[{{ $sfp }}][ps768]" checked="">768 Bytes</label>
                                    </div>
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="sfp[{{ $sfp }}][ps1024]" checked="">1024 Bytes</label>
                                    </div>
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="sfp[{{ $sfp }}][ps1280]" checked="">1280 Bytes</label>
                                    </div>
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="sfp[{{ $sfp }}][ps1518]" checked="">1518 Bytes</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix visible-sm"></div>
                        <div class="col-md-3 col-sm-6">
                            <select class="form-control" name="sfp[{{ $sfp }}][top_rate]">
                                <optgroup label="Channel Top Rate">
                                    <option value="10000" selected="">10 Gb/s</option>
                                    <option value="1000">1 Gb/s</option>
                                </optgroup>
                            </select>
                            <input class="form-control" type="number" name="sfp[{{ $sfp }}][acceptable_loss_rate]" placeholder="Acceptable loss rate (%)" step=".1" min="0" max="10">
                            <input class="form-control" type="text" name="sfp[{{ $sfp }}][rfc_mac_source]">
                            <input class="form-control" type="text" name="sfp[{{ $sfp }}][rfc_mac_destination]">
                        </div>
                    </div>
                </div>
