`ifndef REQUEST_UNIT_IF_VH
`define REQUEST_UNIT_IF_VH
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

interface request_unit_if;

logic dWEN, dREN, dmemREN, dmemWEN, imemREN, dhit, ihit;

modport ru(
    input dWEN, dREN, dhit, ihit,
    output dmemREN, dmemWEN, imemREN
);

modport tb(
    output dWEN, dREN, dhit, ihit,
    input dmemREN, dmemWEN, imemREN
);

endinterface
`endif
