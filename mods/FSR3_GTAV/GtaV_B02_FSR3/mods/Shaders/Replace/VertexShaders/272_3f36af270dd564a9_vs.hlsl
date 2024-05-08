// ---- FNV Hash 3f36af270dd564a9

// ---- Created with 3Dmigoto v1.3.16 on Thu Nov 23 17:10:19 2023
Texture2D<float4> t15 : register(t15);

SamplerComparisonState s15_s : register(s15);

cbuffer cb8 : register(b8)
{
  float4 cb8[7];
}

cbuffer cb6 : register(b6)
{
  float4 cb6[15];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[59];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[14];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[1];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[16];
}

cbuffer cb13 : register(b13)
{
  float4 cb13[1];
}


cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}



// 3Dmigoto declarations
#define cmp -


void main(
  float3 v0 : POSITION0,
  float4 v1 : COLOR0,
  float3 v2 : NORMAL0,
  float4 v3 : TEXCOORD0,
  float4 v4 : TEXCOORD1,
  float4 v5 : TEXCOORD2,
  float4 v6 : TEXCOORD6,
  float4 v7 : TEXCOORD7,
  float4 v8 : TEXCOORD8,
  float4 v9 : TEXCOORD9,
  float4 v10 : TEXCOORD10,
  float4 v11 : TEXCOORD11,
  uint v12 : SV_InstanceID0,
  float4 v13 : TEXCOORD3,
  float4 v14 : TEXCOORD4,
  float4 v15 : TEXCOORD5,
  out float4 o0 : TEXCOORD0,
  out float4 o1 : TEXCOORD1,
  out float4 o2 : TEXCOORD2,
  out float4 o3 : TEXCOORD3,
  out float4 o4 : TEXCOORD5,
  out float4 o5 : TEXCOORD6,
  out float4 o6 : TEXCOORD7,
  out float4 o7 : TEXCOORD8,
  out float4 o8 : TEXCOORD9,
  out float4 o9 : TEXCOORD10,
  out float4 o10 : TEXCOORD11,
  out float4 o11 : TEXCOORD12,
  out float4 o12 : SV_Position0,
  out float4 o13 : SV_ClipDistance0,
  out float4 pos : POSITION0)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v4.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v5.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v6.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v7.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v8.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v9.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v10.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v11.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v13.xy
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14;
  uint4 bitmask, uiDest;
  float4 fDest;

  float4 x0[3];
  float4 x1[3];
  float4 x2[3];
  float4 x3[3];
  float4 x4[4];
  r0.xyz = cb1[15].xyz + -v0.xyz;
  r0.x = dot(r0.xyz, r0.xyz);
  r0.x = sqrt(r0.x);
  r0.y = frac(cb2[13].x);
  r0.y = round(r0.y);
  r1.xyzw = cmp(float4(2,2,1,1) == cb8[2].yzyz);
  r1.xyz = r1.ywy ? r1.xzz : 0;
  r0.z = cmp(0.199900001 < cb8[3].y);
  r0.z = r0.z ? r1.x : 0;
  r1.xw = cmp(cb8[3].yy < float2(0.800100029,0.100001));
  r0.z = r0.z ? r1.x : 0;
  r2.xyzw = cmp(float4(1,0,1,0) == cb8[5].zzww);
  r3.xy = (int2)r2.yw | (int2)r2.xz;
  r0.z = r0.z ? r3.x : 0;
  r0.z = r0.z ? r3.y : 0;
  r4.xyzw = cmp(v1.xyyz < v1.yzxy);
  r0.z = r0.z ? r4.x : 0;
  r5.xyzw = cmp(float4(0,0.200000003,0.100000001,0.5) == cb8[3].yyyy);
  r6.xyzw = r1.yyyz ? r5.xyzx : 0;
  r7.xyzw = r2.xxyx ? r6.xyzw : 0;
  r8.xyzw = r2.zzww ? r7.xyzx : 0;
  r9.xyzw = r4.xzzx ? r8.xzww : 0;
  r3.xzw = cmp(float3(0.300000012,0.5,0.100000001) < v1.xxx);
  r0.w = r3.x ? r8.y : 0;
  r5.xyz = cmp(v1.xxw < float3(0.349999994,0.800000012,0.200000003));
  r0.w = r5.x ? r0.w : 0;
  r0.zw = r4.yx ? r0.zw : 0;
  r0.w = r4.y ? r0.w : 0;
  r10.xyzw = cmp(v4.xxxx == float4(10,2,3,1));
  r1.x = r10.x ? r9.y : 0;
  r7.xy = r2.ww ? r7.wy : 0;
  r7.xy = r4.zz ? r7.xy : 0;
  r7.zw = cmp(v1.yy == v1.xz);
  r1.z = r7.z ? r8.x : 0;
  r1.z = r7.w ? r1.z : 0;
  r1.z = r3.z ? r1.z : 0;
  r1.yz = r1.yz ? r5.wy : 0;
  r1.z = r5.z ? r1.z : 0;
  r0.x = cmp(r0.x < 6);
  r0.x = r0.x ? r1.z : 0;
  r5.xyz = r4.ywy ? r9.xzw : 0;
  r1.z = r4.z ? r8.x : 0;
  r1.z = r4.w ? r1.z : 0;
  r1.y = r2.y ? r1.y : 0;
  r1.yz = r10.zy ? r1.yz : 0;
  r6.xyz = r2.yyx ? r6.yxz : 0;
  r2.y = r2.w ? r6.y : 0;
  r2.y = r4.z ? r2.y : 0;
  r2.y = r4.y ? r2.y : 0;
  r2.y = r10.y ? r2.y : 0;
  r3.xz = r4.ww ? r7.xy : 0;
  r2.z = cmp(14.0390596 < v4.x);
  r2.z = r2.z ? r3.z : 0;
  r3.z = cmp(v4.x < 14.0390701);
  r2.z = r2.z ? r3.z : 0;
  r4.xw = cmp(float2(0.499998987,0.499998987) < cb8[2].yz);
  r6.yw = cmp(cb8[2].yz < float2(1.00000095,1.00000095));
  r3.z = r4.x ? r6.y : 0;
  r3.z = r4.w ? r3.z : 0;
  r3.z = r6.w ? r3.z : 0;
  r1.w = r1.w ? r3.z : 0;
  r1.w = r2.x ? r1.w : 0;
  r1.w = r1.w ? r3.y : 0;
  r1.w = r3.w ? r1.w : 0;
  r3.yz = cmp(v1.yz == float2(0,0));
  r1.w = r1.w ? r3.y : 0;
  r1.w = r3.z ? r1.w : 0;
  if (r1.x != 0) {
    r1.x = cb3[53].z * 0.589589179 + 0.5;
    r2.x = cmp(0 < cb3[53].x);
    r3.y = cmp(cb3[53].x < 0);
    r2.x = (int)-r2.x + (int)r3.y;
    r2.x = (int)r2.x;
    r3.y = r2.x * r1.x;
    r3.z = saturate(58.6954384 * r3.y);
    r3.w = r3.z * -2 + 3;
    r3.z = r3.z * r3.z;
    r4.x = r3.w * r3.z;
    r7.xyzw = r1.xxxx * r2.xxxx + float4(-0.0170370992,-0.0669872984,-0.146446601,-0.25);
    r7.xyzw = saturate(float4(20.0199394,12.5850601,9.65685368,8.29252148) * r7.xyzw);
    r8.xyzw = r7.xyzw * float4(-2,-2,-2,-2) + float4(3,3,3,3);
    r7.xyzw = r7.xyzw * r7.xyzw;
    r7.xyzw = r8.xyzw * r7.xyzw;
    r8.xyzw = r1.xxxx * r2.xxxx + float4(-0.370590597,-0.5,-0.611260593,-0.716941893);
    r8.xyzw = saturate(float4(7.72741413,8.98790836,9.46241188,10.5481997) * r8.xyzw);
    r9.xyzw = r8.xyzw * float4(-2,-2,-2,-2) + float4(3,3,3,3);
    r8.xyzw = r8.xyzw * r8.xyzw;
    r8.xyzw = r9.xyzw * r8.xyzw;
    r9.xyzw = r1.xxxx * r2.xxxx + float4(-0.811744809,-0.890915811,-0.950484514,1);
    r9.xyzw = saturate(float4(12.6308899,16.7873402,27.0420094,79.7695694) * r9.xyzw);
    r11.xyzw = r9.xyzw * float4(-2,-2,-2,-2) + float4(3,3,3,3);
    r9.xyzw = r9.xyzw * r9.xyzw;
    r4.w = -0.987464011 + abs(r3.y);
    r4.w = saturate(79.7703323 * r4.w);
    r5.w = r4.w * -2 + 3;
    r4.w = r4.w * r4.w;
    r4.w = r5.w * r4.w;
    r9.xyz = r11.xyz * r9.xyz;
    r12.xyzw = r1.xxxx * r2.xxxx + float4(0.987463892,0.950484395,0.890915692,0.811744809);
    r12.xyzw = saturate(float4(27.0420094,16.7873402,12.6309099,10.5481796) * r12.xyzw);
    r13.xyzw = r12.xyzw * float4(-2,-2,-2,-2) + float4(3,3,3,3);
    r12.xyzw = r12.xyzw * r12.xyzw;
    r12.xyzw = r13.xyzw * r12.xyzw;
    r13.xyzw = r1.xxxx * r2.xxxx + float4(0.716941714,0.611260414,0.5,0.308658212);
    r13.xyzw = saturate(float4(9.46241188,8.98792267,5.22625017,6.16478682) * r13.xyzw);
    r14.xyzw = r13.xyzw * float4(-2,-2,-2,-2) + float4(3,3,3,3);
    r13.xyzw = r13.xyzw * r13.xyzw;
    r13.xyzw = r14.xyzw * r13.xyzw;
    r6.yw = r1.xx * r2.xx + float2(0.146446601,0.0380601995);
    r6.yw = saturate(float2(9.22624969,26.2741699) * r6.yw);
    r10.xy = r6.yw * float2(-2,-2) + float2(3,3);
    r6.yw = r6.yw * r6.yw;
    r6.yw = r10.xy * r6.yw;
    r1.x = cmp(0 < r3.y);
    r2.x = -r3.w * r3.z + 2;
    r2.x = r7.x * r2.x + r4.x;
    r3.y = 3 + -r2.x;
    r2.x = r7.y * r3.y + r2.x;
    r3.y = 4 + -r2.x;
    r2.x = r7.z * r3.y + r2.x;
    r3.y = 5 + -r2.x;
    r2.x = r7.w * r3.y + r2.x;
    r3.y = 6 + -r2.x;
    r2.x = r8.x * r3.y + r2.x;
    r3.y = 7 + -r2.x;
    r2.x = r8.y * r3.y + r2.x;
    r3.y = 8 + -r2.x;
    r2.x = r8.z * r3.y + r2.x;
    r3.y = 9 + -r2.x;
    r2.x = r8.w * r3.y + r2.x;
    r3.y = 10 + -r2.x;
    r2.x = r9.x * r3.y + r2.x;
    r3.y = 11 + -r2.x;
    r2.x = r9.y * r3.y + r2.x;
    r3.y = 12 + -r2.x;
    r2.x = r9.z * r3.y + r2.x;
    r3.y = 13 + -r2.x;
    r2.x = r4.w * r3.y + r2.x;
    r3.y = r11.w * r9.w + 13;
    r3.z = 15 + -r3.y;
    r3.y = r12.x * r3.z + r3.y;
    r3.z = 16 + -r3.y;
    r3.y = r12.y * r3.z + r3.y;
    r3.z = 17 + -r3.y;
    r3.y = r12.z * r3.z + r3.y;
    r3.z = 18 + -r3.y;
    r3.y = r12.w * r3.z + r3.y;
    r3.z = 19 + -r3.y;
    r3.y = r13.x * r3.z + r3.y;
    r3.z = 20 + -r3.y;
    r3.y = r13.y * r3.z + r3.y;
    r3.z = 21 + -r3.y;
    r3.y = r13.z * r3.z + r3.y;
    r3.z = 22 + -r3.y;
    r3.y = r13.w * r3.z + r3.y;
    r3.z = 23 + -r3.y;
    r3.y = r6.y * r3.z + r3.y;
    r3.z = 24 + -r3.y;
    r3.y = r6.w * r3.z + r3.y;
    r3.z = cmp(24 < r3.y);
    r3.y = r3.z ? 0 : r3.y;
    r1.x = r1.x ? r2.x : r3.y;
    r3.yz = saturate(float2(-4.5,-21) + r1.xx);
    r4.xw = r3.yz * float2(-2,-2) + float2(3,3);
    r3.yz = r3.yz * r3.yz;
    r3.yz = r4.xw * r3.yz;
    r1.x = r3.y * 0.860000014 + 0.140000001;
    r2.x = 0.140000001 + -r1.x;
    r1.x = r3.z * r2.x + r1.x;
    r3.yzw = v7.xyz * float3(1000,1000,1000) + cb2[13].xxx;
    r3.yzw = float3(0,2,4) + r3.yzw;
    r3.yzw = sin(r3.yzw);
    r3.yzw = r3.yzw * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
    o11.yzw = r3.yzw * r1.xxx;
    r7.x = 1.60000002 * v4.w;
    o11.x = r1.x;
  } else {
    o11.xyzw = float4(0,0,0,0);
    r7.x = v4.w;
  }
  r3.yzw = float3(1.72000003,1.72000003,1.72000003) * v1.xyz;
  r8.z = 1.30999994 * r7.x;
  r3.yzw = r0.zzz ? r3.yzw : v1.xyz;
  r8.y = v1.w;
  r7.y = v1.w;
  r7.yz = r0.zz ? r8.yz : r7.yx;
  r8.xy = float2(0.449999988,1.20000005) * r7.yz;
  r7.x = r0.w ? r8.x : r7.y;
  r9.xyz = r3.yzw + r3.yzw;
  r3.yzw = r5.xxx ? r9.xyz : r3.yzw;
  r9.xyz = float3(1.60000002,0.819999993,0.639999986) * r3.yzw;
  r11.w = r7.x + r7.x;
  r11.xyz = float3(9.60000038,4.92000008,3.83999991) * r3.yzw;
  r0.y = cmp(0 < r0.y);
  r9.w = r0.y ? 0 : r11.w;
  r9.xyzw = r10.wwww ? r11.xyzw : r9.xyzw;
  r10.xyz = r5.yyy ? r9.xyz : r3.yzw;
  r8.z = r9.w;
  r0.yz = r5.yy ? r8.zy : r7.xz;
  r0.w = 3 * r0.z;
  r10.w = r3.x ? r0.w : r0.z;
  r3.xyz = float3(7.0999999,7.0999999,7.0999999) * r10.xyz;
  r0.z = cmp(0.000000 == cb8[5].x);
  r0.w = 2.5 * r10.w;
  r3.w = r0.z ? r0.w : r10.w;
  r3.xyzw = r0.xxxx ? r3.xyzw : r10.xyzw;
  r7.xyzw = float4(1.5,0.850000024,0.699999988,1.39999998) * r3.xyzw;
  r3.xyzw = r5.zzzz ? r7.xyzw : r3.xyzw;
  r0.x = r3.w + r3.w;
  r3.w = r1.z ? r0.x : r3.w;
  r0.x = (int)r6.z | (int)r6.x;
  r0.x = r2.w ? r0.x : 0;
  r0.x = r4.z ? r0.x : 0;
  r0.x = r4.y ? r0.x : 0;
  r0.x = (int)r2.z | (int)r0.x;
  r4.xyzw = float4(3.9000001,2.21000004,1.82000005,1.10000002) * r3.xyzw;
  r3.xyzw = r0.xxxx ? r4.xyzw : r3.xyzw;
  r4.xyzw = float4(6,6,6,1.20000005) * r3.xyzw;
  r0.xzw = r1.yyy ? r4.xyz : r3.xyz;
  r1.xyz = float3(4,4,4) * r0.xzw;
  r3.xyz = r2.yyy ? r1.xyz : r0.xzw;
  r0.xzw = r3.xyz * r3.xyz;
  r4.xyz = float3(5,5,5) * r0.xzw;
  r1.xyzw = r1.wwww ? r4.xyzw : r3.xyzw;
  r0.xzw = v7.xyz + v0.xyz;
  r2.x = v6.w;
  r2.y = v7.w;
  r2.z = v8.w;
  r0.xzw = r2.xyz + r0.xzw;
  r2.xyz = v8.xyz + -r2.xyz;
  r3.xyz = -v7.xyz + v6.xyz;
  r4.xyz = r3.xyz + r2.xyz;
  r5.xyz = float3(0.5,0.5,0.5) * r4.xyz;
  r4.xyz = r4.xyz * float3(0.5,0.5,0.5) + r0.xzw;
  r6.xy = v10.yz + -v10.xw;
  r6.zw = v11.yz + -v11.xw;
  x0[0].x = v9.x;
  x0[1].x = 0.5;
  x0[2].x = v9.y;
  x1[0].x = v9.z;
  x1[1].x = 0.5;
  x1[2].x = v9.w;
  x2[0].x = v9.x;
  x2[1].x = 0.5;
  x2[2].x = v9.y;
  x3[0].x = v9.z;
  x3[1].x = 0.5;
  x3[2].x = v9.w;
  r7.xy = trunc(v13.xy);
  r7.xy = (uint2)r7.xy;
  r2.w = x0[r7.x+0].x;
  r3.w = x1[r7.y+0].x;
  r0.xzw = r2.xyz * r2.www + r0.xzw;
  r0.xzw = r3.xyz * r3.www + r0.xzw;
  r2.x = dot(r5.xyz, r5.xyz);
  r2.x = sqrt(r2.x);
  r2.x = 1 / r2.x;
  o1.x = r2.w * r6.x + v10.x;
  o1.y = r3.w * r6.y + v10.w;
  o1.z = r2.w * r6.z + v11.x;
  o1.w = r3.w * r6.w + v11.w;
  r2.y = x2[r7.x+0].x;
  o2.x = r2.y * r6.x + v10.x;
  r2.y = x3[r7.y+0].x;
  o2.y = r2.y * r6.y + v10.w;
  r2.yzw = r4.xyz + -r0.xzw;
  r2.y = dot(r2.yzw, r2.yzw);
  r2.y = sqrt(r2.y);
  r2.x = r2.y * r2.x;
  o3.x = saturate(v3.x);
  r0.xzw = r0.xzw + -r4.xyz;
  r2.yzw = r1.www * r0.xzw;
  r0.xzw = r1.www * r0.xzw + r4.xyz;
  r3.xyz = cb1[15].xyz + -r0.xzw;
  r3.w = dot(r3.xyz, r3.xyz);
  r3.w = rsqrt(r3.w);
  r3.xyz = r3.xyz * r3.www;
  r0.xzw = r3.xyz * cb8[3].yyy + r0.xzw;
  r3.xyz = cb1[15].xyz + -r4.xyz;
  r3.w = dot(r3.xyz, r3.xyz);
  r3.w = rsqrt(r3.w);
  r3.xyz = r3.xyz * r3.www;
  r3.xyz = r3.xyz * cb8[3].yyy + r4.xyz;
  pos.xyzw = float4(r0.x, r0.z, r0.w, 1);
  r4.xyzw = cb1[9].xyzw * r0.zzzz;
  r4.xyzw = r0.xxxx * cb1[8].xyzw + r4.xyzw;
  r4.xyzw = r0.wwww * cb1[10].xyzw + r4.xyzw;
  r4.xyzw = cb1[11].xyzw + r4.xyzw;
  r3.w = cmp(9.99999997e-07 >= r0.y);
  r0.y = r1.w * r0.y;
  o7.x = cb8[4].y * r2.x;
  r5.xyz = -cb1[15].xyz + r0.xzw;
  r1.w = dot(r5.xyz, r5.xyz);
  r2.x = sqrt(r1.w);
  r5.w = -cb8[6].y + r2.x;
  o7.y = saturate(r5.w / cb8[6].x);
  r6.xyz = -r3.xyz + r0.xzw;
  r5.w = dot(r6.xyz, r6.xyz);
  r6.w = cmp(r5.w < 0.00100000005);
  r5.w = rsqrt(r5.w);
  r6.xyz = r6.xyz * r5.www;
  r6.xyz = r6.www ? v2.xyz : r6.xyz;
  r6.xyz = -v2.xyz + r6.xyz;
  r6.xyz = v5.xxx * r6.xyz + v2.xyz;
  r5.w = dot(r6.xyz, r6.xyz);
  r5.w = rsqrt(r5.w);
  r6.xyw = r6.xyz * r5.www;
  r7.xyz = r1.xyz * r1.xyz;
  r8.xy = cb8[2].zz * cb2[12].zy;
  r7.w = saturate(cb3[49].w + cb2[13].z);
  r7.w = r7.w * r8.y;
  r8.y = saturate(r0.w * cb6[3].x + cb6[3].y);
  r8.y = sqrt(r8.y);
  r8.y = -r8.y * cb6[3].z + 1;
  r8.y = cb8[2].y * r8.y;
  r8.z = saturate(dot(r6.xyw, -cb3[0].xyz));
  r8.z = cb13[0].x + r8.z;
  r8.w = cb13[0].x + 1;
  r8.w = r8.w * r8.w;
  r8.z = saturate(r8.z / r8.w);
  r9.xyz = r8.zzz * r7.xyz;
  r9.xyz = cb3[1].xyz * r9.xyz;
  o9.xyz = r9.xyz * r8.yyy;
  r8.yz = cmp(int2(0,2) >= asint(cb3[2].xx));
  r9.x = cmp(0.000000 == cb3[19].w);
  r9.yzw = cb3[3].xyz + -r0.xzw;
  r10.xyz = -cb3[3].xyz + r0.xzw;
  r10.x = dot(r10.xyz, cb3[11].xyz);
  r10.y = cb3[19].w + 9.99999975e-05;
  r10.x = saturate(r10.x / r10.y);
  r10.x = cb3[19].w * r10.x;
  r10.xyz = cb3[11].xyz * r10.xxx + cb3[3].xyz;
  r10.xyz = r10.xyz + -r0.xzw;
  r9.xyz = r9.xxx ? r9.yzw : r10.xyz;
  r9.w = dot(r9.xyz, r9.xyz);
  r9.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r9.xyz;
  r10.x = dot(r9.xyz, r9.xyz);
  r10.x = rsqrt(r10.x);
  r9.xyz = r10.xxx * r9.xyz;
  r9.w = saturate(-r9.w * cb3[3].w + 1);
  r10.x = -cb3[11].w + 1;
  r10.x = r10.x * r9.w + cb3[11].w;
  r9.w = r9.w / r10.x;
  r10.x = dot(r9.xyz, -cb3[11].xyz);
  r10.x = saturate(r10.x * cb3[27].x + cb3[35].x);
  r9.x = saturate(dot(r9.xyz, r6.xyw));
  r9.x = cb13[0].x + r9.x;
  r9.x = saturate(r9.x / r8.w);
  r9.x = r9.x * r10.x;
  r9.x = r9.x * r9.w;
  r9.y = cmp(cb3[19].y < cb3[19].x);
  r9.zw = cb3[19].yz * float2(2.86520004,2.95910001);
  r9.z = cmp(cb3[19].x < r9.z);
  r9.y = r9.z ? r9.y : 0;
  r9.z = cmp(r9.w < cb3[19].y);
  r9.y = r9.z ? r9.y : 0;
  r9.yzw = r9.yyy ? cb3[19].yyy : cb3[19].xyz;
  r9.xyz = r9.yzw * r9.xxx;
  r9.xyz = r9.xyz * r7.xyz;
  r9.xyz = r8.yyy ? float3(0,0,0) : r9.xyz;
  r8.y = cmp(0 < asint(cb3[2].x));
  if (r8.y != 0) {
    r8.y = cmp(1 >= asint(cb3[2].x));
    r10.x = r8.y ? 1.000000 : 0;
    r10.y = cmp(0.000000 == cb3[20].w);
    r11.xyz = cb3[4].xyz + -r0.xzw;
    r12.xyz = -cb3[4].xyz + r0.xzw;
    r10.z = dot(r12.xyz, cb3[12].xyz);
    r10.w = cb3[20].w + 9.99999975e-05;
    r10.z = saturate(r10.z / r10.w);
    r10.z = cb3[20].w * r10.z;
    r12.xyz = cb3[12].xyz * r10.zzz + cb3[4].xyz;
    r12.xyz = r12.xyz + -r0.xzw;
    r10.yzw = r10.yyy ? r11.xyz : r12.xyz;
    r11.x = dot(r10.yzw, r10.yzw);
    r10.yzw = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r10.yzw;
    r11.y = dot(r10.yzw, r10.yzw);
    r11.y = rsqrt(r11.y);
    r10.yzw = r11.yyy * r10.yzw;
    r11.x = saturate(-r11.x * cb3[4].w + 1);
    r11.y = -cb3[12].w + 1;
    r11.y = r11.y * r11.x + cb3[12].w;
    r11.x = r11.x / r11.y;
    r11.y = dot(r10.yzw, -cb3[12].xyz);
    r11.y = saturate(r11.y * cb3[28].x + cb3[36].x);
    r10.y = saturate(dot(r10.yzw, r6.xyw));
    r10.y = cb13[0].x + r10.y;
    r10.y = saturate(r10.y / r8.w);
    r10.y = r10.y * r11.y;
    r10.y = r10.y * r11.x;
    r10.z = cmp(cb3[20].y < cb3[20].x);
    r11.xy = cb3[20].yz * float2(2.86520004,2.95910001);
    r10.w = cmp(cb3[20].x < r11.x);
    r10.z = r10.w ? r10.z : 0;
    r10.w = cmp(r11.y < cb3[20].y);
    r10.z = r10.w ? r10.z : 0;
    r11.xyz = r10.zzz ? cb3[20].yyy : cb3[20].xyz;
    r10.yzw = r11.xyz * r10.yyy;
    r10.yzw = r10.yzw * r7.xyz + r9.xyz;
    r9.xyz = r8.yyy ? r9.xyz : r10.yzw;
  } else {
    r10.x = -1;
  }
  r8.y = cmp(r10.x == 0.000000);
  r10.x = r8.z ? 1.000000 : 0;
  r11.x = cmp(0.000000 == cb3[21].w);
  r11.yzw = cb3[5].xyz + -r0.xzw;
  r12.xyz = -cb3[5].xyz + r0.xzw;
  r12.x = dot(r12.xyz, cb3[13].xyz);
  r12.y = cb3[21].w + 9.99999975e-05;
  r12.x = saturate(r12.x / r12.y);
  r12.x = cb3[21].w * r12.x;
  r12.xyz = cb3[13].xyz * r12.xxx + cb3[5].xyz;
  r12.xyz = r12.xyz + -r0.xzw;
  r11.xyz = r11.xxx ? r11.yzw : r12.xyz;
  r11.w = dot(r11.xyz, r11.xyz);
  r11.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r11.xyz;
  r12.x = dot(r11.xyz, r11.xyz);
  r12.x = rsqrt(r12.x);
  r11.xyz = r12.xxx * r11.xyz;
  r11.w = saturate(-r11.w * cb3[5].w + 1);
  r12.x = -cb3[13].w + 1;
  r12.x = r12.x * r11.w + cb3[13].w;
  r11.w = r11.w / r12.x;
  r12.x = dot(r11.xyz, -cb3[13].xyz);
  r12.x = saturate(r12.x * cb3[29].x + cb3[37].x);
  r11.x = saturate(dot(r11.xyz, r6.xyw));
  r11.x = cb13[0].x + r11.x;
  r11.x = saturate(r11.x / r8.w);
  r11.x = r11.x * r12.x;
  r11.x = r11.x * r11.w;
  r11.y = cmp(cb3[21].y < cb3[21].x);
  r11.zw = cb3[21].yz * float2(2.86520004,2.95910001);
  r11.z = cmp(cb3[21].x < r11.z);
  r11.y = r11.z ? r11.y : 0;
  r11.z = cmp(r11.w < cb3[21].y);
  r11.y = r11.z ? r11.y : 0;
  r11.yzw = r11.yyy ? cb3[21].yyy : cb3[21].xyz;
  r11.xyz = r11.yzw * r11.xxx;
  r11.xyz = r11.xyz * r7.xyz + r9.xyz;
  r10.yzw = r8.zzz ? r9.xyz : r11.xyz;
  r9.w = -1;
  r9.xyzw = r8.yyyy ? r10.yzwx : r9.xyzw;
  r8.y = cmp(r9.w == 0.000000);
  if (r8.y != 0) {
    r8.y = cmp(3 >= asint(cb3[2].x));
    r8.z = cmp(0.000000 == cb3[22].w);
    r10.xyz = cb3[6].xyz + -r0.xzw;
    r11.xyz = -cb3[6].xyz + r0.xzw;
    r9.w = dot(r11.xyz, cb3[14].xyz);
    r10.w = cb3[22].w + 9.99999975e-05;
    r9.w = saturate(r9.w / r10.w);
    r9.w = cb3[22].w * r9.w;
    r11.xyz = cb3[14].xyz * r9.www + cb3[6].xyz;
    r0.xzw = r11.xyz + -r0.xzw;
    r0.xzw = r8.zzz ? r10.xyz : r0.xzw;
    r8.z = dot(r0.xzw, r0.xzw);
    r0.xzw = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r0.xzw;
    r9.w = dot(r0.xzw, r0.xzw);
    r9.w = rsqrt(r9.w);
    r0.xzw = r9.www * r0.xzw;
    r8.z = saturate(-r8.z * cb3[6].w + 1);
    r9.w = -cb3[14].w + 1;
    r9.w = r9.w * r8.z + cb3[14].w;
    r8.z = r8.z / r9.w;
    r9.w = dot(r0.xzw, -cb3[14].xyz);
    r9.w = saturate(r9.w * cb3[30].x + cb3[38].x);
    r0.x = saturate(dot(r0.xzw, r6.xyw));
    r0.x = cb13[0].x + r0.x;
    r0.x = saturate(r0.x / r8.w);
    r0.x = r0.x * r9.w;
    r0.x = r0.x * r8.z;
    r0.z = cmp(cb3[22].y < cb3[22].x);
    r8.zw = cb3[22].yz * float2(2.86520004,2.95910001);
    r0.w = cmp(cb3[22].x < r8.z);
    r0.z = r0.w ? r0.z : 0;
    r0.w = cmp(r8.w < cb3[22].y);
    r0.z = r0.w ? r0.z : 0;
    r10.xyz = r0.zzz ? cb3[22].yyy : cb3[22].xyz;
    r0.xzw = r10.xyz * r0.xxx;
    r0.xzw = r0.xzw * r7.xyz + r9.xyz;
    r9.xyz = r8.yyy ? r9.xyz : r0.xzw;
  }
  r0.x = r6.z * r5.w + cb3[43].w;
  r0.x = cb3[44].w * r0.x;
  r0.x = max(0, r0.x);
  r0.z = cmp(cb3[47].y < cb3[47].x);
  r8.yz = cb3[47].yz * float2(2.86520004,2.95910001);
  r0.w = cmp(cb3[47].x < r8.y);
  r0.z = r0.w ? r0.z : 0;
  r0.w = cmp(r8.z < cb3[47].y);
  r0.z = r0.w ? r0.z : 0;
  r8.yzw = r0.zzz ? cb3[47].yyy : cb3[47].xyz;
  r0.z = cmp(cb3[48].y < cb3[48].x);
  r10.xy = cb3[48].yz * float2(2.86520004,2.95910001);
  r0.w = cmp(cb3[48].x < r10.x);
  r0.z = r0.w ? r0.z : 0;
  r0.w = cmp(r10.y < cb3[48].y);
  r0.z = r0.w ? r0.z : 0;
  r10.xyz = r0.zzz ? cb3[48].yyy : cb3[48].xyz;
  r8.yzw = r8.yzw * r0.xxx + r10.xyz;
  r0.z = -cb2[13].z + 1;
  r10.xyz = cb3[45].xyz * r0.xxx + cb3[46].xyz;
  r10.xyz = cb2[13].zzz * r10.xyz;
  r8.yzw = r8.yzw * r0.zzz + r10.xyz;
  r8.yzw = r8.yzw * r7.www;
  r0.xzw = cb3[43].xyz * r0.xxx + cb3[44].xyz;
  r10.x = cb3[46].w;
  r10.y = cb3[47].w;
  r10.z = cb3[48].w;
  r5.w = saturate(dot(r10.xyz, r6.xyw));
  r0.xzw = cb3[49].xyz * r5.www + r0.xzw;
  r0.xzw = r0.xzw * r8.xxx + r8.yzw;
  r0.xzw = r0.xzw * r7.xyz;
  o0.xyz = r9.xyz * cb8[3].xxx + r0.xzw;
  r0.x = cb6[14].z * -1.5 + 1;
  r0.x = 0.5 * r0.x;
  r6.xyz = r3.xyz;
  r0.zw = float2(0,0);
  while (true) {
    r5.w = cmp((int)r0.w >= 4);
    if (r5.w != 0) break;
    r7.xyz = -cb1[15].xyz + r6.xyz;
    r8.xyz = cb6[1].xyz * r7.yyy;
    r7.xyw = r7.xxx * cb6[0].xyz + r8.xyz;
    r7.xyz = r7.zzz * cb6[2].xyz + r7.xyw;
    r8.xyz = r7.xyz * cb6[4].xyz + cb6[8].xyz;
    x4[0].xyz = r8.xyz;
    r9.xyz = r7.xyz * cb6[5].xyz + cb6[9].xyz;
    x4[1].xyz = r9.xyz;
    r10.xyz = r7.xyz * cb6[6].xyz + cb6[10].xyz;
    x4[2].xyz = r10.xyz;
    r7.xyz = r7.xyz * cb6[7].xyz + cb6[11].xyz;
    x4[3].xyz = r7.xyz;
    r5.w = max(abs(r10.x), abs(r10.y));
    r5.w = cmp(r5.w < r0.x);
    r5.w = r5.w ? 2 : 3;
    r6.w = max(abs(r9.x), abs(r9.y));
    r6.w = cmp(r6.w < r0.x);
    r5.w = r6.w ? 1 : r5.w;
    r6.w = max(abs(r8.x), abs(r8.y));
    r6.w = cmp(r6.w < r0.x);
    r5.w = r6.w ? 0 : r5.w;
    r6.w = (uint)r5.w;
    r7.xyz = x4[r6.w+0].xyz;
    r5.w = 0.5 + r5.w;
    r5.w = 0.25 * r5.w;
    r8.x = 0.5 + r7.x;
    r8.y = r7.y * 0.25 + r5.w;
    r5.w = t15.SampleCmpLevelZero(s15_s, r8.xy, r7.z).x;
    r0.z = r5.w + r0.z;
    r6.xyz = r2.yzw * float3(0.25,0.25,0.25) + r6.xyz;
    r0.w = (int)r0.w + 1;
  }
  r0.x = r0.z * 0.25 + -1;
  o7.z = v4.z * r0.x + 1;
  r0.x = v4.y * r0.y;
  o0.w = r3.w ? 0 : r0.x;
  r0.x = -cb3[50].x + r2.x;
  r0.x = max(0, r0.x);
  r0.y = r0.x / r2.x;
  r0.y = r5.z * r0.y;
  r0.z = cb3[52].z * r0.y;
  r0.y = cmp(0.00999999978 < abs(r0.y));
  r0.w = -1.44269502 * r0.z;
  r0.w = exp2(r0.w);
  r0.w = 1 + -r0.w;
  r0.z = r0.w / r0.z;
  r0.y = r0.y ? r0.z : 1;
  r0.z = cb3[51].w * r0.x;
  r0.y = r0.z * r0.y;
  r0.y = min(1, r0.y);
  r0.y = 1.44269502 * r0.y;
  r0.y = exp2(r0.y);
  r0.y = min(1, r0.y);
  r0.y = 1 + -r0.y;
  r0.z = cb3[52].y * r0.y;
  r0.w = rsqrt(r1.w);
  r2.xyz = r5.xyz * r0.www;
  r0.w = saturate(dot(r2.xyz, cb3[54].xyz));
  r0.w = log2(r0.w);
  r0.w = cb3[54].w * r0.w;
  r0.w = exp2(r0.w);
  r1.w = saturate(dot(r2.xyz, cb3[53].xyz));
  r1.w = log2(r1.w);
  r1.w = cb3[53].w * r1.w;
  r1.w = exp2(r1.w);
  r0.y = -r0.y * cb3[52].y + 1;
  r0.y = cb3[51].y * r0.y;
  r2.x = -cb3[52].x + r0.x;
  r2.x = max(0, r2.x);
  r2.x = cb3[51].x * r2.x;
  r2.x = 1.44269502 * r2.x;
  r2.x = exp2(r2.x);
  r2.x = 1 + -r2.x;
  o4.w = saturate(r0.y * r2.x + r0.z);
  r0.x = -cb3[51].z * r0.x;
  r0.x = 1.44269502 * r0.x;
  r0.x = exp2(r0.x);
  r0.x = 1 + -r0.x;
  r2.xyz = cb3[58].xyz + -cb3[56].xyz;
  r2.xyz = r0.www * r2.xyz + cb3[56].xyz;
  r3.xyz = cb3[55].xyz + -r2.xyz;
  r2.xyz = r1.www * r3.xyz + r2.xyz;
  r2.xyz = -cb3[57].xyz + r2.xyz;
  r0.xzw = r0.xxx * r2.xyz + cb3[57].xyz;
  r2.x = cb3[55].w + -r0.x;
  r2.y = cb3[56].w + -r0.z;
  r2.z = cb3[57].w + -r0.w;
  o4.xyz = r0.yyy * r2.xyz + r0.xzw;
  o13.x = dot(r4.xyzw, cb0[0].xyzw);
  o2.zw = float2(0,0);
  o5.x = v4.x;
  o5.yzw = r1.xyz;
  o6.xy = v5.xy;
  o6.zw = float2(0,0);
  o7.w = r4.w;
  o8.xyzw = float4(0,0,0,0);
  o10.xyzw = float4(0,0,0,0);
  o12.xyzw = r4.xyzw;
  o13.yzw = float3(0,0,0);
  o3.y = v3.y;
  return;
}