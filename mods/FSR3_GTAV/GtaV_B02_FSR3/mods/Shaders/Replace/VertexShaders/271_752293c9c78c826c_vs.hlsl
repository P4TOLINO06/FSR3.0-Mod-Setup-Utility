// ---- FNV Hash 752293c9c78c826c

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 20 02:46:44 2023
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb3 : register(b3)
{
  float4 cb3[55];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[16];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[14];
}

cbuffer cb5 : register(b5)
{
  float4 cb5[76];
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
  float4 v0 : POSITION0,
  float4 v1 : TEXCOORD0,
  out float4 o0 : SV_Position0,
  out float4 o1 : TEXCOORD0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD2,
  out float4 o4 : TEXCOORD3,
  out float4 o5 : TEXCOORD4,
  out float4 o6 : TEXCOORD10,
  out float4 o7 : TEXCOORD11,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xyzw
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = t0.SampleLevel(s0_s, v1.zw, 0).y;
  r0.y = cb5[75].w * 0.980000019;
  r0.x = cmp(r0.x >= r0.y);
  r0.x = r0.x ? 1.000000 : 0;
  r1.x = v1.x * v0.z + v0.x;
  r1.y = -v1.y * v0.w + v0.y;
  r0.yz = float2(-0.5,0.5) + r1.xy;
  r1.xy = r0.yz + r0.yz;
  r0.yz = r0.yz * float2(2,-2) + float2(1,1);
  r1.zw = float2(0,1);
  o0.xyzw = r1.xyzw * r0.xxxx;
  o1.xy = float2(0.5,0.5) * r0.yz;
  r0.xy = r0.yz * float2(1,-1) + float2(-1,1);
  r0.xy = cb5[0].xy * r0.xy;
  r0.z = cmp(0 < cb3[53].x);
  r0.w = cmp(cb3[53].x < 0);
  r0.z = (int)-r0.z + (int)r0.w;
  r0.z = (int)r0.z;
  r0.w = cb3[53].z * 0.589589179 + 0.5;
  r1.xyzw = r0.wwww * r0.zzzz + float4(-0.0170370992,-0.0669872984,-0.146446601,-0.25);
  r1.xyzw = saturate(float4(20.0199394,12.5850601,9.65685368,8.29252148) * r1.xyzw);
  r2.xyzw = r1.xyzw * float4(-2,-2,-2,-2) + float4(3,3,3,3);
  r1.xyzw = r1.xyzw * r1.xyzw;
  r1.xyzw = r2.xyzw * r1.xyzw;
  r2.x = r0.w * r0.z;
  r2.y = saturate(58.6954384 * r2.x);
  r2.z = r2.y * -2 + 3;
  r2.y = r2.y * r2.y;
  r2.w = r2.z * r2.y;
  r2.y = -r2.z * r2.y + 2;
  r1.x = r1.x * r2.y + r2.w;
  r2.y = 3 + -r1.x;
  r1.x = r1.y * r2.y + r1.x;
  r1.y = 4 + -r1.x;
  r1.x = r1.z * r1.y + r1.x;
  r1.y = 5 + -r1.x;
  r1.x = r1.w * r1.y + r1.x;
  r1.y = 6 + -r1.x;
  r3.xyzw = r0.wwww * r0.zzzz + float4(-0.370590597,-0.5,-0.611260593,-0.716941893);
  r3.xyzw = saturate(float4(7.72741413,8.98790836,9.46241188,10.5481997) * r3.xyzw);
  r4.xyzw = r3.xyzw * float4(-2,-2,-2,-2) + float4(3,3,3,3);
  r3.xyzw = r3.xyzw * r3.xyzw;
  r3.xyzw = r4.xyzw * r3.xyzw;
  r1.x = r3.x * r1.y + r1.x;
  r1.y = 7 + -r1.x;
  r1.x = r3.y * r1.y + r1.x;
  r1.y = 8 + -r1.x;
  r1.x = r3.z * r1.y + r1.x;
  r1.y = 9 + -r1.x;
  r1.x = r3.w * r1.y + r1.x;
  r1.y = 10 + -r1.x;
  r3.xyzw = r0.wwww * r0.zzzz + float4(-0.811744809,-0.890915811,-0.950484514,1);
  r3.xyzw = saturate(float4(12.6308899,16.7873402,27.0420094,79.7695694) * r3.xyzw);
  r4.xyzw = r3.xyzw * float4(-2,-2,-2,-2) + float4(3,3,3,3);
  r3.xyzw = r3.xyzw * r3.xyzw;
  r2.yzw = r4.xyz * r3.xyz;
  r1.z = r4.w * r3.w + 13;
  r1.x = r2.y * r1.y + r1.x;
  r1.y = 11 + -r1.x;
  r1.x = r2.z * r1.y + r1.x;
  r1.y = 12 + -r1.x;
  r1.x = r2.w * r1.y + r1.x;
  r1.y = 13 + -r1.x;
  r1.w = -0.987464011 + abs(r2.x);
  r2.x = cmp(0 < r2.x);
  r1.w = saturate(79.7703323 * r1.w);
  r2.y = r1.w * -2 + 3;
  r1.w = r1.w * r1.w;
  r1.w = r2.y * r1.w;
  r1.x = r1.w * r1.y + r1.x;
  r3.xyzw = r0.wwww * r0.zzzz + float4(0.987463892,0.950484395,0.890915692,0.811744809);
  r3.xyzw = saturate(float4(27.0420094,16.7873402,12.6309099,10.5481796) * r3.xyzw);
  r4.xyzw = r3.xyzw * float4(-2,-2,-2,-2) + float4(3,3,3,3);
  r3.xyzw = r3.xyzw * r3.xyzw;
  r3.xyzw = r4.xyzw * r3.xyzw;
  r1.y = 15 + -r1.z;
  r1.y = r3.x * r1.y + r1.z;
  r1.z = 16 + -r1.y;
  r1.y = r3.y * r1.z + r1.y;
  r1.z = 17 + -r1.y;
  r1.y = r3.z * r1.z + r1.y;
  r1.z = 18 + -r1.y;
  r1.y = r3.w * r1.z + r1.y;
  r1.z = 19 + -r1.y;
  r3.xyzw = r0.wwww * r0.zzzz + float4(0.716941714,0.611260414,0.5,0.308658212);
  r0.zw = r0.ww * r0.zz + float2(0.146446601,0.0380601995);
  r0.zw = saturate(float2(9.22624969,26.2741699) * r0.zw);
  r3.xyzw = saturate(float4(9.46241188,8.98792267,5.22625017,6.16478682) * r3.xyzw);
  r4.xyzw = r3.xyzw * float4(-2,-2,-2,-2) + float4(3,3,3,3);
  r3.xyzw = r3.xyzw * r3.xyzw;
  r3.xyzw = r4.xyzw * r3.xyzw;
  r1.y = r3.x * r1.z + r1.y;
  r1.z = 20 + -r1.y;
  r1.y = r3.y * r1.z + r1.y;
  r1.z = 21 + -r1.y;
  r1.y = r3.z * r1.z + r1.y;
  r1.z = 22 + -r1.y;
  r1.y = r3.w * r1.z + r1.y;
  r1.z = 23 + -r1.y;
  r2.yz = r0.zw * float2(-2,-2) + float2(3,3);
  r0.zw = r0.zw * r0.zw;
  r0.zw = r2.yz * r0.zw;
  r0.z = r0.z * r1.z + r1.y;
  r1.y = 24 + -r0.z;
  r0.z = r0.w * r1.y + r0.z;
  r0.w = cmp(24 < r0.z);
  r0.z = r0.w ? 0 : r0.z;
  r0.z = r2.x ? r1.x : r0.z;
  r0.w = cmp(cb5[61].w < 0.5);
  r1.x = cmp(cb3[52].x < 0.0002199999);
  r0.w = r0.w ? r1.x : 0;
  r1.x = cb3[52].x * 100000;
  r1.y = -cb3[52].x * 5263.43994 + 5.26306009;
  r0.w = r0.w ? r1.y : r1.x;
  r1.x = cmp(0.000609999988 < cb5[63].y);
  r1.y = cmp(cb5[63].y < 0.000890000025);
  r1.x = r1.y ? r1.x : 0;
  r1.y = cmp(0.961000025 < cb2[13].w);
  r1.x = r1.y ? r1.x : 0;
  r1.y = cmp(cb2[13].w < 1.00100005);
  r1.x = r1.y ? r1.x : 0;
  r0.z = r1.x ? r0.w : r0.z;
  r1.yzw = float3(-22,-4.0999999,-21.8999996) + r0.zzz;
  r1.yzw = saturate(float3(0.5,10.0000095,9.99996185) * r1.yzw);
  r2.xyz = r1.yzw * float3(-2,-2,-2) + float3(3,3,3);
  r1.yzw = r1.yzw * r1.yzw;
  r1.yzw = r2.xyz * r1.yzw;
  r2.xyzw = saturate(float4(-18,-19,-20,-21) + r0.zzzz);
  r3.xyzw = r2.xyzw * float4(-2,-2,-2,-2) + float4(3,3,3,3);
  r2.xyzw = r2.xyzw * r2.xyzw;
  r2.xyzw = r3.xyzw * r2.xyzw;
  r3.xyzw = float4(-16,-17,-10,-12) + r0.zzzz;
  r3.xy = saturate(r3.xy);
  r3.zw = saturate(float2(0.5,0.25) * r3.zw);
  r4.xy = r3.xy * float2(-2,-2) + float2(3,3);
  r3.xy = r3.xy * r3.xy;
  r3.xy = r4.xy * r3.xy;
  r4.xy = r3.zw * float2(-2,-2) + float2(3,3);
  r3.zw = r3.zw * r3.zw;
  r3.zw = r4.xy * r3.zw;
  r4.xyzw = float4(-4,-5,-6,-7) + r0.zzzz;
  r0.w = saturate(0.333333313 * r4.w);
  r4.xyz = saturate(r4.xyz);
  r4.w = r0.w * -2 + 3;
  r0.w = r0.w * r0.w;
  r0.w = r4.w * r0.w;
  r5.xyz = r4.xyz * float3(-2,-2,-2) + float3(3,3,3);
  r4.xyz = r4.xyz * r4.xyz;
  r4.xyz = r5.xyz * r4.xyz;
  r5.xyzw = r4.xxxx * float4(0.0300000906,-0.0399999619,-0.0500000715,-0.0900000334) + float4(1.65999997,1.55999994,1.57000005,1.61000001);
  r6.xyzw = float4(1.67999995,1.54999995,1.5,1.5) + -r5.xyzw;
  r5.xyzw = r4.yyyy * r6.xyzw + r5.xyzw;
  r6.xyzw = float4(1.65999997,1.54999995,1.51999998,1.51999998) + -r5.xyzw;
  r5.xyzw = r4.zzzz * r6.xyzw + r5.xyzw;
  r6.xyzw = float4(1.65999997,1.55999994,1.53999996,1.53999996) + -r5.xyzw;
  r5.xyzw = r0.wwww * r6.xyzw + r5.xyzw;
  r6.xyzw = float4(1.66999996,1.55999994,1.57000005,1.57000005) + -r5.xyzw;
  r5.xyzw = r3.zzzz * r6.xyzw + r5.xyzw;
  r6.xyzw = float4(1.65999997,1.54999995,1.55999994,1.55999994) + -r5.xyzw;
  r5.xyzw = r3.wwww * r6.xyzw + r5.xyzw;
  r6.xyzw = float4(1.65999997,1.54999995,1.55999994,1.55999994) + -r5.xyzw;
  r5.xyzw = r3.xxxx * r6.xyzw + r5.xyzw;
  r6.xyzw = float4(1.65999997,1.58000004,1.58000004,1.58000004) + -r5.xyzw;
  r5.xyzw = r3.yyyy * r6.xyzw + r5.xyzw;
  r6.xyzw = float4(1.65999997,1.59000003,1.58000004,1.58000004) + -r5.xyzw;
  r5.xyzw = r2.xxxx * r6.xyzw + r5.xyzw;
  r6.xyzw = float4(1.65999997,1.57000005,1.58000004,1.58000004) + -r5.xyzw;
  r5.xyzw = r2.yyyy * r6.xyzw + r5.xyzw;
  r6.xyzw = float4(1.70000005,1.58000004,1.59000003,1.59000003) + -r5.xyzw;
  r5.xyzw = r2.zzzz * r6.xyzw + r5.xyzw;
  r6.xyzw = float4(1.70000005,1.55999994,1.57000005,1.61000001) + -r5.xyzw;
  r5.xyzw = r2.wwww * r6.xyzw + r5.xyzw;
  r6.xyzw = float4(1.65999997,1.55999994,1.57000005,1.61000001) + -r5.xyzw;
  r5.xyzw = r1.yyyy * r6.xyzw + r5.xyzw;
  r4.w = r2.z * 0.00999999046 + 1.61000001;
  r6.x = 1.62 + -r4.w;
  r4.w = r2.w * r6.x + r4.w;
  r6.x = 1.61000001 + -r4.w;
  r4.w = r1.y * r6.x + r4.w;
  r4.w = r4.w + -r5.x;
  r6.xy = cb5[63].yy * float2(10000,1000);
  r6.x = saturate(r6.x);
  r6.z = r6.x * -2 + 3;
  r6.x = r6.x * r6.x;
  r6.x = r6.z * r6.x;
  r4.w = r6.x * r4.w + r5.x;
  r5.x = r5.y + -r4.w;
  r7.xyzw = cb5[63].yyyy * float4(1000,1000,1000,1000) + float4(-0.100000001,-0.200000003,-0.300000012,-0.400000006);
  r7.xyzw = saturate(float4(10,9.99999905,10,10) * r7.xyzw);
  r8.xyzw = r7.xyzw * float4(-2,-2,-2,-2) + float4(3,3,3,3);
  r7.xyzw = r7.xyzw * r7.xyzw;
  r7.xyzw = r8.xyzw * r7.xyzw;
  r4.w = r7.x * r5.x + r4.w;
  r5.x = r5.z + -r4.w;
  r4.w = r7.y * r5.x + r4.w;
  r5.x = r5.w + -r4.w;
  r4.w = r7.z * r5.x + r4.w;
  r5.xyz = r4.xxx * float3(-0.0399999619,-0.0399999619,-0.0399999619) + float3(1.5,1.51999998,1.50999999);
  r8.xyz = float3(1.46000004,1.47000003,1.46000004) + -r5.xyz;
  r5.xyz = r4.yyy * r8.xyz + r5.xyz;
  r8.xyz = float3(1.46000004,1.48000002,1.47000003) + -r5.xyz;
  r5.xyz = r4.zzz * r8.xyz + r5.xyz;
  r8.xyz = float3(1.45000005,1.48000002,1.47000003) + -r5.xyz;
  r5.xyz = r0.www * r8.xyz + r5.xyz;
  r8.xyz = float3(1.45000005,1.49000001,1.47000003) + -r5.xyz;
  r5.xyz = r3.zzz * r8.xyz + r5.xyz;
  r8.xyz = float3(1.45000005,1.48000002,1.47000003) + -r5.xyz;
  r5.xyz = r3.www * r8.xyz + r5.xyz;
  r8.xyz = float3(1.45000005,1.48000002,1.47000003) + -r5.xyz;
  r5.xyz = r3.xxx * r8.xyz + r5.xyz;
  r8.xyz = float3(1.46000004,1.47000003,1.46000004) + -r5.xyz;
  r5.xyz = r3.yyy * r8.xyz + r5.xyz;
  r8.xyz = float3(1.46000004,1.48000002,1.47000003) + -r5.xyz;
  r5.xyz = r2.xxx * r8.xyz + r5.xyz;
  r8.xyz = float3(1.46000004,1.49000001,1.48000002) + -r5.xyz;
  r5.xyz = r2.yyy * r8.xyz + r5.xyz;
  r8.xyz = float3(1.46000004,1.49000001,1.48000002) + -r5.xyz;
  r5.xyz = r2.zzz * r8.xyz + r5.xyz;
  r8.xyz = float3(1.5,1.52999997,1.51999998) + -r5.xyz;
  r5.xyz = r2.www * r8.xyz + r5.xyz;
  r8.xyz = float3(1.5,1.51999998,1.50999999) + -r5.xyz;
  r5.xyz = r1.yyy * r8.xyz + r5.xyz;
  r4.x = r5.x + -r4.w;
  r4.x = r7.w * r4.x + r4.w;
  r4.w = r5.y + -r4.x;
  r5.xyw = cb5[63].yyy * float3(1000,1000,1000) + float3(-0.5,-0.600000024,-0.699999988);
  r5.xyw = saturate(float3(9.99999809,10,9.99999809) * r5.xyw);
  r8.xyz = r5.xyw * float3(-2,-2,-2) + float3(3,3,3);
  r5.xyw = r5.xyw * r5.xyw;
  r5.xyw = r8.xyz * r5.xyw;
  r4.x = r5.x * r4.w + r4.x;
  r4.w = r5.z + -r4.x;
  r4.x = r5.y * r4.w + r4.x;
  r4.w = r0.w * -0.00999999046 + 1.53999996;
  r5.z = 1.52999997 + -r4.w;
  r4.w = r3.z * r5.z + r4.w;
  r5.z = 1.52999997 + -r4.w;
  r4.w = r3.w * r5.z + r4.w;
  r5.z = 1.52999997 + -r4.w;
  r4.w = r3.x * r5.z + r4.w;
  r5.z = 1.54999995 + -r4.w;
  r4.w = r3.y * r5.z + r4.w;
  r5.z = 1.55999994 + -r4.w;
  r4.w = r2.x * r5.z + r4.w;
  r5.z = 1.57000005 + -r4.w;
  r4.w = r2.y * r5.z + r4.w;
  r5.z = 1.57000005 + -r4.w;
  r4.w = r2.z * r5.z + r4.w;
  r5.z = 1.54999995 + -r4.w;
  r4.w = r2.w * r5.z + r4.w;
  r5.z = 1.53999996 + -r4.w;
  r4.w = r1.y * r5.z + r4.w;
  r4.w = r4.w + -r4.x;
  o2.xyzw = r5.wwww * r4.wwww + r4.xxxx;
  r8.xyzw = r6.xxxx * float4(165,-44,-44,-45) + float4(1540,880,660,1090);
  r9.xyzw = r6.xxxx * float4(0,-44,0,0) + float4(1144,649,0.340000004,0.0219999999);
  r10.xyzw = float4(1375,770,473,803) + -r8.xyzw;
  r8.xyzw = r7.xxxx * r10.xyzw + r8.xyzw;
  r10.xyzw = float4(1331,715,363,759) + -r8.xyzw;
  r8.xyzw = r7.yyyy * r10.xyzw + r8.xyzw;
  r10.xyzw = float4(1331,715,440,759) + -r8.xyzw;
  r8.xyzw = r7.zzzz * r10.xyzw + r8.xyzw;
  r10.xyzw = float4(1331,726,297,847) + -r8.xyzw;
  r8.xyzw = r7.wwww * r10.xyzw + r8.xyzw;
  r10.xyzw = float4(1331,726,330,759) + -r8.xyzw;
  r8.xyzw = r5.xxxx * r10.xyzw + r8.xyzw;
  r10.xyzw = float4(1331,726,330,759) + -r8.xyzw;
  r8.xyzw = r5.yyyy * r10.xyzw + r8.xyzw;
  r10.xyzw = float4(1331,726,330,759) + -r8.xyzw;
  o3.xyzw = r5.wwww * r10.xyzw + r8.xyzw;
  r8.xyzw = float4(1374,506,0.340000004,0.023) + -r9.xyzw;
  r8.xyzw = r7.xxxx * r8.xyzw + r9.xyzw;
  r9.xyzw = float4(1331,451,0.340000004,0.0270000007) + -r8.xyzw;
  r8.xyzw = r7.yyyy * r9.xyzw + r8.xyzw;
  r9.xyzw = float4(1331,451,0.340000004,0.0277777798) + -r8.xyzw;
  r8.xyzw = r7.zzzz * r9.xyzw + r8.xyzw;
  r9.xyzw = float4(1331,451,0.340000004,0.0277777798) + -r8.xyzw;
  r7.xyzw = r7.wwww * r9.xyzw + r8.xyzw;
  r8.xyzw = float4(1331,451,0.340000004,0.0277777798) + -r7.xyzw;
  r7.xyzw = r5.xxxx * r8.xyzw + r7.xyzw;
  r8.xyzw = float4(1331,451,0.340000004,0.0277777798) + -r7.xyzw;
  r7.xyzw = r5.yyyy * r8.xyzw + r7.xyzw;
  r8.xyzw = float4(1331,451,0.340000004,0.0277777798) + -r7.xyzw;
  o4.xyzw = r5.wwww * r8.xyzw + r7.xyzw;
  r5.xyz = cb1[13].xyz * r0.yyy;
  r5.xyz = r0.xxx * cb1[12].xyz + r5.xyz;
  o5.xyz = -cb1[14].xyz + r5.xyz;
  o5.w = r0.z;
  r0.x = saturate(0.200000003 * r0.z);
  r0.y = r0.x * -2 + 3;
  r0.x = r0.x * r0.x;
  r0.x = r0.y * r0.x;
  r5.xyz = r0.xxx * float3(0.965925872,-0.392746806,0.938000023) + float3(0,0.529900014,-0.84799999);
  r6.xzw = float3(1,0,0.0900000036) + -r5.xyz;
  r5.xyz = r4.yyy * r6.xzw + r5.xyz;
  r6.xzw = float3(0.974927783,-0.117918201,0.188708603) + -r5.xyz;
  r5.xyz = r4.zzz * r6.xzw + r5.xyz;
  r6.xzw = float3(0.623489797,-0.414307594,0.663030684) + -r5.xyz;
  r5.xyz = r0.www * r6.xzw + r5.xyz;
  r6.xzw = float3(0.222520694,-0.516633213,0.826785803) + -r5.xyz;
  r5.xyz = r3.zzz * r6.xzw + r5.xyz;
  r6.xzw = float3(-0.623489916,-0.414307594,0.663030624) + -r5.xyz;
  r5.xyz = r3.www * r6.xzw + r5.xyz;
  r6.xzw = float3(-0.781831622,-0.330399185,0.528749228) + -r5.xyz;
  r5.xyz = r3.xxx * r6.xzw + r5.xyz;
  r6.xzw = float3(-0.900969028,-0.229923204,0.367953986) + -r5.xyz;
  r5.xyz = r3.yyy * r6.xzw + r5.xyz;
  r6.xzw = float3(-0.974927902,-0.117918201,0.25999999) + -r5.xyz;
  r5.xyz = r2.xxx * r6.xzw + r5.xyz;
  r6.xzw = float3(-1,0,0.25999999) + -r5.xyz;
  r5.xyz = r2.yyy * r6.xzw + r5.xyz;
  r6.xzw = float3(-0.923879385,0.202791393,0.247824401) + -r5.xyz;
  r5.xyz = r2.zzz * r6.xzw + r5.xyz;
  r6.xzw = float3(-0.7259112,0.658729613,0.215906203) + -r5.xyz;
  r5.xyz = r2.www * r6.xzw + r5.xyz;
  r6.xzw = float3(0,0.529900014,-0.84799999) + -r5.xyz;
  r5.xyz = r1.yyy * r6.xzw + r5.xyz;
  r5.xyz = r1.xxx ? r5.xyz : cb3[53].xyz;
  r5.xyz = -cb3[54].xyz + r5.xyz;
  r5.xyz = r1.zzz * r5.xyz + cb3[54].xyz;
  r6.xzw = cb3[54].xyz + -r5.xyz;
  r5.xyz = r1.www * r6.xzw + r5.xyz;
  r5.xyz = cb1[15].xyz + r5.xyz;
  r6.xzw = cb1[9].xyw * r5.yyy;
  r5.xyw = r5.xxx * cb1[8].xyw + r6.xzw;
  r5.xyz = r5.zzz * cb1[10].xyw + r5.xyw;
  r5.xyz = cb1[11].xyw + r5.xyz;
  r0.yz = r5.xy / r5.zz;
  o6.xy = r0.yz * float2(0.5,-0.5) + float2(0.5,0.5);
  r0.y = 0.965925872 * r0.x;
  r0.x = -r0.x * 0.965925872 + 1;
  r0.x = r4.y * r0.x + r0.y;
  r0.y = 0.974927783 + -r0.x;
  r0.x = r4.z * r0.y + r0.x;
  r0.y = 0.623489797 + -r0.x;
  r0.x = r0.w * r0.y + r0.x;
  r0.y = 0.222520694 + -r0.x;
  r0.x = r3.z * r0.y + r0.x;
  r0.y = -0.623489916 + -r0.x;
  r0.x = r3.w * r0.y + r0.x;
  r0.y = -0.781831622 + -r0.x;
  r0.x = r3.x * r0.y + r0.x;
  r0.y = -0.900969028 + -r0.x;
  r0.x = r3.y * r0.y + r0.x;
  r0.y = -0.974927902 + -r0.x;
  r0.x = r2.x * r0.y + r0.x;
  r0.y = -1 + -r0.x;
  r0.x = r2.y * r0.y + r0.x;
  r0.y = -0.923879385 + -r0.x;
  r0.x = r2.z * r0.y + r0.x;
  r0.y = -0.7259112 + -r0.x;
  r0.x = r2.w * r0.y + r0.x;
  r0.x = r1.y * -r0.x + r0.x;
  r0.y = r1.x ? r0.x : cb3[53].x;
  r0.y = -cb3[54].x + r0.y;
  r0.y = r1.z * r0.y + cb3[54].x;
  r0.z = cb3[54].x + -r0.y;
  r0.y = r1.w * r0.z + r0.y;
  r0.xy = float2(900,900) * r0.xy;
  r0.z = -cb5[63].y * 58479.5 + 87.7192993;
  r0.z = saturate(r6.y * r0.z + -31.7485008);
  r0.z = cmp(0.00100000005 < r0.z);
  o7.w = r0.z ? r0.x : r0.y;
  o7.xyz = float3(0,0,0);
  return;
}