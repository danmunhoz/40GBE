
                <div class="col-md-12" id="form_timed_throughput">
                    <div>
                        <div class="col-md-3">
                            <label>Packet size:</label>
                            <input class="form-control" type="number" name="sfp[{{ $sfp }}][custom_size]" placeholder="Number of bytes" min="64" max="9000">
                        </div>
                        <div class="col-md-3">
                        </div>
                        <div class="col-md-3">
                            <input class="form-control" type="number" name="sfp[{{ $sfp }}][throughput_rate]" placeholder="Throughput (Mb/s)" min="1" max="10000">
                            <input class="form-control" type="number" name="sfp[{{ $sfp }}][timed_throughput_time]" placeholder="Time (s)" min="1">
                            <input class="form-control" type="number" name="sfp[{{ $sfp }}][acceptable_timed_loss_rate]" placeholder="Acceptable loss rate (%)" step=".1" min="0" max="10">
                            <input class="form-control" type="text" name="sfp[{{ $sfp }}][timed_mac_source]">
                            <input class="form-control" type="text" name="sfp[{{ $sfp }}][timed_mac_destination]">
                        </div>
                        <div class="col-md-3 col-md-offset-0">
                            <h4>Select Payload type</h4>
                            <select class="form-control" name="sfp[{{ $sfp }}][payload_selector]">
                                <!-- <option value="0">Packet ID</option> -->
                                <option value="1">LFSR</option>
                                <option value="2">All zeros</option>
                            </select>
                            <select class="form-control" name="sfp[{{ $sfp }}][polynome_selector]">
                                <option value="0">X^30 + X^27 + 1</option>
                                <option value="1">X^22 + X^17 + 1</option>
                                <option value="2">X^14 + X^13 + 1</option>
                                <option value="3">X^6  + X^5  + 1</option>
                            </select>
                        </div>
                    </div>
                </div>
