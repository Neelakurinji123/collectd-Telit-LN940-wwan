/* Licensed to the public under the Apache License 2.0. */

'use strict';
'require baseclass';

return baseclass.extend({
//	title: _('Exec'),
	title: _('Mobile Signal Quality'),

	rrdargs: function(graph, host, plugin, plugin_instance, dtype) {
                /*
                 * Reference Signal Received Power
                 */
                var s_rsrp = {
                        title: "%H: RSRP - Reference Signal Received Power on %pi",
                        detail: true,
			y_min: "-100",
			y_max: "-80",
                        vlabel: "dBm",
                        number_format: "%5.1lf dBm",
                        data: {
                                types: [ "mobile_signal_rsrp" ],
                                options: {
                                        mobile_signal_rsrp: {
                                                title  : "RSRP",
                                                overlay: false,
                                                color  : "ff0000",
						noarea: true,
						// weight: 5
                                        }
                                }
                        }
                };

                /*
                 * Received Signal Strength Indicator
                 */
                var s_rssi = {
                        title: "%H: RSSI - Received Signal Strength Indicator on %pi",
                        detail: true,
			y_min: "-90",
			y_max: "-60",
                        vlabel: "dBm",
                        number_format: "%4.1lf dBm",
                        data: {
                                types: [ "mobile_signal_rssi" ],
                                options: {
                                        mobile_signal_rssi: {
                                                title  : "RSSI",
                                                overlay: false,
                                                color  : "ff00ff",
						noarea: true,
						// weight: 5
                                        }
                                }
                        }
                };

                /*
                 * Reference Signal Received Quality
                 */
                var s_rsrq = {
                        title: "%H: RSRQ - Reference Signal Received Quality on %pi",
                        detail: true,
			y_min: "-25",
			y_max: "-5",
                        vlabel: "dB",
                        number_format: "%4.1lf dB",
                        data: {
                                types: [ "mobile_signal_rsrq" ],
                                options: {
                                        mobile_signal_rsrq: {
                                                title  : "RSRQ",
                                                overlay: false,
                                                color  : "00cc00",
						noarea: true,
						// weight: 5
                                        }
                                }
                        }
                };

                /*
                 * Signal to Interference & Noise Ratio
                 */
                var s_sinr = {
                        title: "%H: SINR - Signal to Interference & Noise Ratio on %pi",
                        detail: true,
			y_min: "0",
			y_max: "20",
                        vlabel: "dB",
                        number_format: "%3.1lf dB",
                        data: {
                                types: [ "mobile_signal_sinr" ],
                                options: {
                                        mobile_signal_sinr: {
                                                title  : "SINR",
                                                overlay: false,
                                                color  : "0000cc",
						noarea: true
                                        }
                                }
                        }
                };

		return [ s_rsrp, s_rssi, s_rsrq, s_sinr ];
	}
});
