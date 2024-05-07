// ---- FNV Hash e6b2944e0f812c9c

// ---- Created with 3Dmigoto v1.3.16 on Sat Mar  9 08:17:12 2024
Texture2D<float4> t2 : register(t2);

SamplerState s2_s : register(s2);

cbuffer cb3 : register(b3)
{
  float4 cb3[54];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[14];
}

cbuffer cb11 : register(b11)
{
  float4 cb11[8];
}

cbuffer cb12 : register(b12)
{
  float4 cb12[5];
}

cbuffer cb7 : register(b7)
{
  float4 cb7[1];
}

cbuffer cb0 : register(b0)
{
  float4 cb0[1];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[16];
}

cbuffer cb4 : register(b4)
{
  float4 cb4[765];
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
  float4 v1 : BLENDWEIGHT0,
  float4 v2 : BLENDINDICES0,
  float4 v3 : TEXCOORD0,
  float2 v4 : TEXCOORD1,
  float3 v5 : NORMAL0,
  float4 v6 : COLOR0,
  out float4 o0 : TEXCOORD0,
  out float4 o1 : TEXCOORD1,
  out float4 o2 : TEXCOORD2,
  out float4 o3 : TEXCOORD3,
  out float4 o4 : TEXCOORD6,
  out float4 o5 : TEXCOORD8,
  out float4 o6 : SV_Position0,
  out float4 o7 : SV_ClipDistance0,
  out float4 pos : POSITION0)
{

  pos.xyzw = float4(v0.xyz, 1);
  const float4 icb[] = { { 1.000000, 0, 0, 0},
                              { 0, 1.000000, 0, 0},
                              { 0, 0, 1.000000, 0},
                              { 0, 0, 0, 1.000000},
                              { 1.000000, 0, 0, 0},
                              { 0, 1.000000, 0, 0},
                              { 0, 0, 1.000000, 0},
                              { 0, 0, 0, 1.000000},
                              { 1.000000, 0, 0, 0},
                              { 0, 1.000000, 0, 0},
                              { 0, 0, 1.000000, 0},
                              { 0, 0, 0, 1.000000},
                              { 1.000000, 0, 0, 0},
                              { 0, 1.000000, 0, 0},
                              { 0, 0, 1.000000, 0},
                              { 0, 0, 0, 1.000000},
                              { 1.000000, 0, 0, 0},
                              { 0, 1.000000, 0, 0},
                              { 0, 0, 1.000000, 0} };
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.z
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v4.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v5.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v6.xyw
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.x = cb7[0].x ? 1 : 0;
  if (r0.x != 0) {
    r0.xyz = cb12[1].xyz + v0.xyz;
    r0.w = dot(r0.xyz, r0.xyz);
    r0.w = sqrt(r0.w);
    r0.xyz = r0.xyz / r0.www;
    r0.z = 1 + -r0.z;
    r0.z = 0.5 * r0.z;
    r1.x = dot(r0.xy, r0.xy);
    r1.x = max(9.99999994e-09, r1.x);
    r1.x = sqrt(r1.x);
    r1.xyzw = r0.xyxy / r1.xxxx;
    r1.xyzw = r1.xyzw * r0.zzzz;
    r1.xyzw = r1.xyzw * float4(0.5,0.5,0.5,0.5) + float4(0.5,0.5,0.5,0.5);
    r2.xyzw = float4(126.732697,126.732697,126.732697,126.732697) * r1.zwzw;
    r3.xyzw = cmp(r2.zwzw >= -r2.zwzw);
    r2.xyzw = frac(abs(r2.xyzw));
    r2.xyzw = r3.xyzw ? r2.xyzw : -r2.zwzw;
    r3.xyzw = t2.SampleLevel(s2_s, r1.zw, 0).xyzw;
    r1.xyzw = r2.xyzw * float4(-0.00789062493,-0.00789062493,-0.00789062493,-0.00789062493) + r1.xyzw;
    r4.xyzw = float4(0.00789062493,0,0,0.00789062493) + r1.zwzw;
    r5.xyzw = t2.SampleLevel(s2_s, r4.xy, 0).xyzw;
    r4.xyzw = t2.SampleLevel(s2_s, r4.zw, 0).xyzw;
    r6.xyzw = float4(0.00789062493,0.00789062493,-0.5,-0.5) + r1.zwzw;
    r7.xyzw = t2.SampleLevel(s2_s, r6.xy, 0).xyzw;
    r0.xy = float2(1,1) + -r2.zw;
    r8.xyz = r0.xxx * r3.xyz;
    r9.xyz = r5.xyz * r2.zzz;
    r9.xyz = r9.xyz * r0.yyy;
    r8.xyz = r8.xyz * r0.yyy + r9.xyz;
    r0.xyz = r0.xxx * r4.xyz;
    r0.xyz = r0.xyz * r2.www + r8.xyz;
    r2.xyz = r7.xyz * r2.zzz;
    r0.xyz = r2.xyz * r2.www + r0.xyz;
    r0.w = r0.w / cb12[0].x;
    r0.w = min(1, r0.w);
    r0.xyz = r0.xyz * r0.www;
    r0.xyz = cb12[0].yyy * r0.xyz;
    r2.x = dot(r0.xyz, r0.xyz);
    r2.x = sqrt(r2.x);
    r2.x = min(1, r2.x);
    r2.x = r2.x * -4 + 1;
    o1.w = max(0, r2.x);
    r2.xyz = r0.xyz * v6.yyy + v0.xyz;
    r0.x = cmp(0 < cb12[2].w);
    r7.xyz = cb12[2].xyz + -cb12[1].xyz;
    r7.xzw = -r7.xyz + r2.xyz;
    r0.y = dot(r7.xzw, r7.xzw);
    r0.y = sqrt(r0.y);
    r0.z = cb12[2].w * 1.10000002;
    r3.w = saturate(r0.y / r0.z);
    r4.w = cmp(r3.w < 1);
    r0.y = r7.z / r0.y;
    r3.w = r3.w * 0.100000001 + 0.899999976;
    r0.y = r3.w * r0.y;
    r0.y = r0.y * r0.z + r7.y;
    r0.y = r4.w ? r0.y : r2.y;
    r2.w = r0.x ? r0.y : r2.y;
    r0.x = cmp(0 < cb12[3].w);
    r7.xyz = cb12[3].xyz + -cb12[1].xyz;
    r7.xzw = -r7.xyz + r2.xwz;
    r0.y = dot(r7.xzw, r7.xzw);
    r0.y = sqrt(r0.y);
    r0.z = cb12[3].w * 1.10000002;
    r3.w = saturate(r0.y / r0.z);
    r4.w = cmp(r3.w < 1);
    r0.y = r7.z / r0.y;
    r3.w = r3.w * 0.100000001 + 0.899999976;
    r0.y = r3.w * r0.y;
    r0.y = r0.y * r0.z + r7.y;
    r0.y = r4.w ? r0.y : r2.w;
    r2.y = r0.x ? r0.y : r2.w;
    r0.xy = r6.zw + r6.zw;
    r0.z = dot(r0.xy, r0.xy);
    r3.w = cmp(0 < r0.z);
    r0.z = sqrt(r0.z);
    r0.z = r3.w ? r0.z : 0;
    r3.w = r0.z * -2 + 1;
    r6.z = max(-1, r3.w);
    r3.w = cmp(r6.z < 1);
    r4.w = cmp(-1 < r6.z);
    r3.w = r3.w ? r4.w : 0;
    r4.w = cmp(0 < r0.z);
    r3.w = r3.w ? r4.w : 0;
    r4.w = -r6.z * r6.z + 1;
    r4.w = sqrt(r4.w);
    r0.z = r4.w / r0.z;
    r0.z = r3.w ? r0.z : 0;
    r6.xy = r0.xy * r0.zz;
    r0.xyz = r3.xyz * r0.www;
    r0.xyz = cb12[0].yyy * r0.xyz;
    r1.xyzw = float4(-0.492109388,-0.5,-0.5,-0.492109388) + r1.xyzw;
    r1.xyzw = r1.xyzw + r1.xyzw;
    r3.x = dot(r1.xy, r1.xy);
    r3.y = cmp(0 < r3.x);
    r3.x = sqrt(r3.x);
    r3.x = r3.y ? r3.x : 0;
    r3.y = r3.x * -2 + 1;
    r7.z = max(-1, r3.y);
    r3.y = cmp(r7.z < 1);
    r3.y = r3.y ? 1.000000 : 0;
    r3.z = cmp(-1 < r7.z);
    r3.y = r3.y ? r3.z : 0;
    r3.z = cmp(0 < r3.x);
    r3.y = r3.y ? r3.z : 0;
    r3.z = -r7.z * r7.z + 1;
    r3.z = sqrt(r3.z);
    r3.x = r3.z / r3.x;
    r3.y = cmp(0 != r3.y);
    r3.x = r3.y ? r3.x : 0;
    r7.xy = r3.xx * r1.xy;
    r3.xyz = r5.xyz * r0.www;
    r5.xyz = r7.xyz + -r6.xyz;
    r3.xyz = r3.xyz * cb12[0].yyy + -r0.xyz;
    r1.x = dot(r3.xyz, v5.xyz);
    r1.y = dot(r5.xyz, r5.xyz);
    r3.x = cmp(0 < r1.y);
    r7.x = r1.x / r1.y;
    r7.y = 1;
    r3.yzw = r7.xyx * r5.xyz;
    r7.z = v6.y;
    r3.yzw = r7.zxz * r3.yzw;
    r5.xz = float2(0.100000001,0.333299994);
    r5.y = v6.y;
    r3.yzw = r3.yzw * r5.xyz + v5.xyz;
    r3.xyz = r3.xxx ? r3.yzw : v5.xyz;
    r1.x = dot(r1.zw, r1.zw);
    r1.y = cmp(0 < r1.x);
    r1.x = sqrt(r1.x);
    r1.x = r1.y ? r1.x : 0;
    r1.y = r1.x * -2 + 1;
    r7.z = max(-1, r1.y);
    r1.y = cmp(r7.z < 1);
    r3.w = cmp(-1 < r7.z);
    r1.y = r1.y ? r3.w : 0;
    r3.w = cmp(0 < r1.x);
    r1.y = r1.y ? r3.w : 0;
    r3.w = -r7.z * r7.z + 1;
    r3.w = sqrt(r3.w);
    r1.x = r3.w / r1.x;
    r1.x = r1.y ? r1.x : 0;
    r7.xy = r1.zw * r1.xx;
    r1.xyz = r4.xyz * r0.www;
    r4.xyz = r7.xyz + -r6.xyz;
    r0.xyz = r1.xyz * cb12[0].yyy + -r0.xyz;
    r0.x = dot(r0.xyz, v5.xyz);
    r0.y = dot(r4.xyz, r4.xyz);
    r0.z = cmp(0 < r0.y);
    r1.x = r0.x / r0.y;
    r1.y = 1;
    r0.xyw = r1.xyx * r4.xyz;
    r1.z = v6.y;
    r0.xyw = r1.zxz * r0.xyw;
    r0.xyw = r0.xyw * r5.xyz + r3.xyz;
    r0.xyz = r0.zzz ? r0.xyw : r3.xyz;
    r0.xyz = float3(9.99999975e-05,9.99999975e-05,9.99999975e-05) + r0.xyz;
    r0.w = dot(r0.xyz, r0.xyz);
    r0.w = rsqrt(r0.w);
    r0.xyz = r0.xyz * r0.www;
  } else {
    r0.xyz = v5.xyz;
    r2.xyz = v0.xyz;
    o1.w = 1;
  }
  r0.w = v6.w * 255 + 0.5;
  r0.w = (uint)r0.w;
  r1.x = (uint)r0.w >> 2;
  r1.y = dot(cb11[r1.x+3].xyzw, icb[r0.w+0].xyzw);
  r3.xyz = cmp(r1.yyy == cb11[4].yzw);
  r0.w = (int)r3.y | (int)r3.x;
  r1.w = cmp(r1.y == cb11[5].x);
  r1.w = (int)r1.w | (int)r3.z;
  r0.w = (int)r0.w | (int)r1.w;
  r1.w = cb2[13].y * -630 + 800;
  o5.y = (int)r0.w & (int)r1.w;
  r3.xy = float2(3.5,255.001999) * v2.zz;
  r0.w = ceil(r3.x);
  r0.w = cb2[13].x * 0.48828131 + r0.w;
  r0.w = sin(r0.w);
  o5.w = abs(r0.w);
  r1.x = v6.x * r1.y;
  r0.w = (uint)r3.y;
  r0.w = (int)r0.w * 3;
  r2.w = 1;
  r1.w = dot(cb4[r0.w+0].xyzw, r2.xyzw);
  r3.x = dot(cb4[r0.w+1].xyzw, r2.xyzw);
  r2.x = dot(cb4[r0.w+2].xyzw, r2.xyzw);
  r2.yzw = cb1[1].xyz * r3.xxx;
  r2.yzw = r1.www * cb1[0].xyz + r2.yzw;
  r2.yzw = r2.xxx * cb1[2].xyz + r2.yzw;
  r2.yzw = cb1[3].xyz + r2.yzw;
  o3.xyz = cb1[15].xyz + -r2.yzw;
  r3.y = dot(cb4[r0.w+0].xyz, r0.xyz);
  r3.z = dot(cb4[r0.w+1].xyz, r0.xyz);
  r0.x = dot(cb4[r0.w+2].xyz, r0.xyz);
  r0.yzw = cb1[1].xyz * r3.zzz;
  r0.yzw = r3.yyy * cb1[0].xyz + r0.yzw;
  o1.xyz = r0.xxx * cb1[2].xyz + r0.yzw;
  r0.xyzw = cb1[9].xyzw * r3.xxxx;
  r0.xyzw = r1.wwww * cb1[8].xyzw + r0.xyzw;
  r0.xyzw = r2.xxxx * cb1[10].xyzw + r0.xyzw;
  r0.xyzw = cb1[11].xyzw + r0.xyzw;
  r1.w = cb12[4].x ? 1 : 0;
  if (r1.w != 0) {
    r3.xyz = cb12[1].xyz + v0.xyz;
    r1.w = dot(r3.xyz, r3.xyz);
    r1.w = sqrt(r1.w);
    r3.xyz = r3.xyz / r1.www;
    r2.x = 1 + -r3.z;
    r2.x = 0.5 * r2.x;
    r3.z = dot(r3.xy, r3.xy);
    r3.z = max(9.99999994e-09, r3.z);
    r3.z = sqrt(r3.z);
    r3.xyzw = r3.xyxy / r3.zzzz;
    r3.xyzw = r3.xyzw * r2.xxxx;
    r3.xyzw = r3.xyzw * float4(0.5,0.5,0.5,0.5) + float4(0.5,0.5,0.5,0.5);
    r4.xyzw = float4(126.732697,126.732697,126.732697,126.732697) * r3.zwzw;
    r5.xyzw = cmp(r4.zwzw >= -r4.zwzw);
    r4.xyzw = frac(abs(r4.xyzw));
    r4.xyzw = r5.xyzw ? r4.xyzw : -r4.zwzw;
    r5.xyzw = t2.SampleLevel(s2_s, r3.zw, 0).xyzw;
    r3.xyzw = r4.xyzw * float4(-0.00789062493,-0.00789062493,-0.00789062493,-0.00789062493) + r3.xyzw;
    r3.xyzw = float4(0.00789062493,0,0,0.00789062493) + r3.xyzw;
    r6.xyzw = t2.SampleLevel(s2_s, r3.xy, 0).xyzw;
    r7.xyzw = t2.SampleLevel(s2_s, r3.zw, 0).xyzw;
    r3.xyzw = t2.SampleLevel(s2_s, r3.xw, 0).xyzw;
    r4.xy = float2(1,1) + -r4.zw;
    r5.xyzw = r5.xyzw * r4.xxxx;
    r6.xyzw = r6.xyzw * r4.zzzz;
    r6.xyzw = r6.xyzw * r4.yyyy;
    r5.xyzw = r5.xyzw * r4.yyyy + r6.xyzw;
    r6.xyzw = r7.xyzw * r4.xxxx;
    r5.xyzw = r6.xyzw * r4.wwww + r5.xyzw;
    r3.xyzw = r3.xyzw * r4.zzzz;
    r3.xyzw = r3.xyzw * r4.wwww + r5.xyzw;
    r1.w = r1.w / cb12[0].x;
    r1.w = min(1, r1.w);
    r3.xyzw = r3.xyzw * r1.wwww;
    r3.xyzw = r3.xyzw * float4(0.5,0.5,0.5,0.5) + float4(0.5,0.5,0.5,0.5);
  } else {
    r3.xyzw = r1.xxxy;
  }
  r1.z = 1;
  r3.xyzw = cb12[4].xxxx ? r1.xxxz : r3.xyzw;
  r1.x = cb3[53].z * 0.589589179 + 0.5;
  r1.z = cmp(0 < cb3[53].x);
  r1.w = cmp(cb3[53].x < 0);
  r1.z = (int)-r1.z + (int)r1.w;
  r1.z = (int)r1.z;
  r1.w = r1.x * r1.z;
  r2.x = saturate(58.6954384 * r1.w);
  r4.x = r2.x * -2 + 3;
  r2.x = r2.x * r2.x;
  r4.y = r4.x * r2.x;
  r5.xyzw = r1.xxxx * r1.zzzz + float4(-0.0170370992,-0.0669872984,-0.146446601,-0.25);
  r5.xyzw = saturate(float4(20.0199394,12.5850601,9.65685368,8.29252148) * r5.xyzw);
  r6.xyzw = r5.xyzw * float4(-2,-2,-2,-2) + float4(3,3,3,3);
  r5.xyzw = r5.xyzw * r5.xyzw;
  r5.xyzw = r6.xyzw * r5.xyzw;
  r6.xyzw = r1.xxxx * r1.zzzz + float4(-0.370590597,-0.5,-0.611260593,-0.716941893);
  r6.xyzw = saturate(float4(7.72741413,8.98790836,9.46241188,10.5481997) * r6.xyzw);
  r7.xyzw = r6.xyzw * float4(-2,-2,-2,-2) + float4(3,3,3,3);
  r6.xyzw = r6.xyzw * r6.xyzw;
  r6.xyzw = r7.xyzw * r6.xyzw;
  r7.xyzw = r1.xxxx * r1.zzzz + float4(-0.811744809,-0.890915811,-0.950484514,1);
  r7.xyzw = saturate(float4(12.6308899,16.7873402,27.0420094,79.7695694) * r7.xyzw);
  r8.xyzw = r7.xyzw * float4(-2,-2,-2,-2) + float4(3,3,3,3);
  r7.xyzw = r7.xyzw * r7.xyzw;
  r4.z = -0.987464011 + abs(r1.w);
  r4.z = saturate(79.7703323 * r4.z);
  r4.w = r4.z * -2 + 3;
  r4.z = r4.z * r4.z;
  r4.z = r4.w * r4.z;
  r7.xyz = r8.xyz * r7.xyz;
  r9.xyzw = r1.xxxx * r1.zzzz + float4(0.987463892,0.950484395,0.890915692,0.811744809);
  r9.xyzw = saturate(float4(27.0420094,16.7873402,12.6309099,10.5481796) * r9.xyzw);
  r10.xyzw = r9.xyzw * float4(-2,-2,-2,-2) + float4(3,3,3,3);
  r9.xyzw = r9.xyzw * r9.xyzw;
  r9.xyzw = r10.xyzw * r9.xyzw;
  r10.xyzw = r1.xxxx * r1.zzzz + float4(0.716941714,0.611260414,0.5,0.308658212);
  r10.xyzw = saturate(float4(9.46241188,8.98792267,5.22625017,6.16478682) * r10.xyzw);
  r11.xyzw = r10.xyzw * float4(-2,-2,-2,-2) + float4(3,3,3,3);
  r10.xyzw = r10.xyzw * r10.xyzw;
  r10.xyzw = r11.xyzw * r10.xyzw;
  r1.xz = r1.xx * r1.zz + float2(0.146446601,0.0380601995);
  r1.xz = saturate(float2(9.22624969,26.2741699) * r1.xz);
  r8.xy = r1.xz * float2(-2,-2) + float2(3,3);
  r1.xz = r1.xz * r1.xz;
  r1.xz = r8.xy * r1.xz;
  r2.x = -r4.x * r2.x + 2;
  r2.x = r5.x * r2.x + r4.y;
  r4.x = 3 + -r2.x;
  r2.x = r5.y * r4.x + r2.x;
  r4.x = 4 + -r2.x;
  r2.x = r5.z * r4.x + r2.x;
  r4.x = 5 + -r2.x;
  r2.x = r5.w * r4.x + r2.x;
  r4.x = 6 + -r2.x;
  r2.x = r6.x * r4.x + r2.x;
  r4.x = 7 + -r2.x;
  r2.x = r6.y * r4.x + r2.x;
  r4.x = 8 + -r2.x;
  r2.x = r6.z * r4.x + r2.x;
  r4.x = 9 + -r2.x;
  r2.x = r6.w * r4.x + r2.x;
  r4.x = 10 + -r2.x;
  r2.x = r7.x * r4.x + r2.x;
  r4.x = 11 + -r2.x;
  r2.x = r7.y * r4.x + r2.x;
  r4.x = 12 + -r2.x;
  r2.x = r7.z * r4.x + r2.x;
  r4.x = 13 + -r2.x;
  r2.x = r4.z * r4.x + r2.x;
  r4.x = r8.w * r7.w + 13;
  r4.y = 15 + -r4.x;
  r4.x = r9.x * r4.y + r4.x;
  r4.y = 16 + -r4.x;
  r4.x = r9.y * r4.y + r4.x;
  r4.y = 17 + -r4.x;
  r4.x = r9.z * r4.y + r4.x;
  r4.y = 18 + -r4.x;
  r4.x = r9.w * r4.y + r4.x;
  r4.y = 19 + -r4.x;
  r4.x = r10.x * r4.y + r4.x;
  r4.y = 20 + -r4.x;
  r4.x = r10.y * r4.y + r4.x;
  r4.y = 21 + -r4.x;
  r4.x = r10.z * r4.y + r4.x;
  r4.y = 22 + -r4.x;
  r4.x = r10.w * r4.y + r4.x;
  r4.y = 23 + -r4.x;
  r1.x = r1.x * r4.y + r4.x;
  r4.x = 24 + -r1.x;
  r1.x = r1.z * r4.x + r1.x;
  r1.zw = cmp(float2(24,0) < r1.xw);
  r1.x = r1.z ? 0 : r1.x;
  r1.x = r1.w ? r2.x : r1.x;
  r4.xyzw = float4(-4.30000019,-5.5,-6,-17.2999992) + r1.xxxx;
  r4.xzw = saturate(float3(1.42857206,1.11111104,1.42857003) * r4.xzw);
  r5.xyz = r4.xzw * float3(-2,-2,-2) + float3(3,3,3);
  r4.xzw = r4.xzw * r4.xzw;
  r1.z = saturate(r4.y + r4.y);
  r1.w = r1.z * -2 + 3;
  r1.z = r1.z * r1.z;
  r1.z = r1.w * r1.z;
  r4.xyz = r5.xyz * r4.xzw;
  r5.xyzw = float4(-19,-18.2999992,-20.1000004,-21.2999992) + r1.xxxx;
  r5.yzw = saturate(float3(1.42857003,1.111112,1.42857003) * r5.yzw);
  r6.xyz = r5.yzw * float3(-2,-2,-2) + float3(3,3,3);
  r5.yzw = r5.yzw * r5.yzw;
  r5.x = saturate(r5.x);
  r1.x = r5.x * -2 + 3;
  r1.w = r5.x * r5.x;
  r1.x = r1.x * r1.w;
  r5.xyz = r6.xyz * r5.yzw;
  r1.w = r4.x * 2.29999995 + 1;
  r2.x = 1.5 + -r1.w;
  r1.z = r1.z * r2.x + r1.w;
  r1.w = 1 + -r1.z;
  r1.z = r4.y * r1.w + r1.z;
  r1.w = 1.10000002 + -r1.z;
  r1.z = r4.z * r1.w + r1.z;
  r1.w = 9.69999981 + -r1.z;
  r1.z = r5.x * r1.w + r1.z;
  r1.w = 8.89999962 + -r1.z;
  r1.x = r1.x * r1.w + r1.z;
  r1.z = 3.29999995 + -r1.x;
  r1.x = r5.y * r1.z + r1.x;
  r1.z = 1 + -r1.x;
  r1.x = r5.z * r1.z + r1.x;
  o4.x = r3.x * r1.x;
  o7.x = dot(r0.xyzw, cb0[0].xyzw);
  o2.xyz = r2.yzw;
  o2.w = 1;
  o4.yzw = r3.yzw;
  o5.x = r1.y;
  o5.z = v2.z;
  o6.xyzw = r0.xyzw;
  o7.yzw = float3(0,0,0);
  o0.xy = v3.xy;
  o0.zw = v4.xy;
  return;
}