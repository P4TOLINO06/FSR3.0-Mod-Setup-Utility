// ---- FNV Hash 871ace5dff0d2d26

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 20 02:46:44 2023
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
  out float4 o11 : SV_Position0,
  out float4 o12 : SV_ClipDistance0,
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
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10;
  uint4 bitmask, uiDest;
  float4 fDest;

  float4 x0[3];
  float4 x1[3];
  float4 x2[3];
  float4 x3[3];
  float4 x4[4];
  r0.xyz = v7.xyz + v0.xyz;
  r1.x = v6.w;
  r1.y = v7.w;
  r1.z = v8.w;
  r0.xyz = r1.xyz + r0.xyz;
  r1.xyz = v8.xyz + -r1.xyz;
  r2.xyz = -v7.xyz + v6.xyz;
  r3.xyz = r2.xyz + r1.xyz;
  r4.xyz = float3(0.5,0.5,0.5) * r3.xyz;
  r3.xyz = r3.xyz * float3(0.5,0.5,0.5) + r0.xyz;
  r5.xy = v10.yz + -v10.xw;
  r5.zw = v11.yz + -v11.xw;
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
  r6.xy = (int2)v13.xy;
  r0.w = x0[r6.x+0].x;
  r1.w = x1[r6.y+0].x;
  r0.xyz = r1.xyz * r0.www + r0.xyz;
  r0.xyz = r2.xyz * r1.www + r0.xyz;
  r1.x = dot(r4.xyz, r4.xyz);
  r1.x = sqrt(r1.x);
  r1.x = 1 / r1.x;
  o1.x = r0.w * r5.x + v10.x;
  o1.y = r1.w * r5.y + v10.w;
  o1.z = r0.w * r5.z + v11.x;
  o1.w = r1.w * r5.w + v11.w;
  r0.w = x2[r6.x+0].x;
  o2.x = r0.w * r5.x + v10.x;
  r0.w = x3[r6.y+0].x;
  o2.y = r0.w * r5.y + v10.w;
  r1.yzw = r3.xyz + -r0.xyz;
  r0.w = dot(r1.yzw, r1.yzw);
  r0.w = sqrt(r0.w);
  r0.w = r0.w * r1.x;
  o3.x = saturate(v3.x);
  r0.xyz = r0.xyz + -r3.xyz;
  r1.xyz = v4.www * r0.xyz;
  r0.xyz = r0.xyz * v4.www + r3.xyz;
  r2.xyz = cb1[15].xyz + -r0.xyz;
  r1.w = dot(r2.xyz, r2.xyz);
  r1.w = rsqrt(r1.w);
  r2.xyz = r2.xyz * r1.www;
  r0.xyz = r2.xyz * cb8[3].yyy + r0.xyz;
  r2.xyz = cb1[15].xyz + -r3.xyz;
  r1.w = dot(r2.xyz, r2.xyz);
  r1.w = rsqrt(r1.w);
  r2.xyz = r2.xyz * r1.www;
  r2.xyz = r2.xyz * cb8[3].yyy + r3.xyz;
  pos.xyzw = float4(r0.xyz, 1);
  r3.xyzw = cb1[9].xyzw * r0.yyyy;
  r3.xyzw = r0.xxxx * cb1[8].xyzw + r3.xyzw;
  r3.xyzw = r0.zzzz * cb1[10].xyzw + r3.xyzw;
  r3.xyzw = cb1[11].xyzw + r3.xyzw;
  r1.w = cmp(9.99999997e-07 >= v1.w);
  r2.w = v4.w * v1.w;
  o7.x = cb8[4].y * r0.w;
  r4.xyz = -cb1[15].xyz + r0.xyz;
  r0.w = dot(r4.xyz, r4.xyz);
  r4.w = sqrt(r0.w);
  r5.x = -cb8[6].y + r4.w;
  o7.y = saturate(r5.x / cb8[6].x);
  r5.xyz = -r2.xyz + r0.xyz;
  r5.w = dot(r5.xyz, r5.xyz);
  r6.x = cmp(r5.w < 0.00100000005);
  r5.w = rsqrt(r5.w);
  r5.xyz = r5.xyz * r5.www;
  r5.xyz = r6.xxx ? v2.xyz : r5.xyz;
  r5.xyz = -v2.xyz + r5.xyz;
  r5.xyz = v5.xxx * r5.xyz + v2.xyz;
  r5.w = dot(r5.xyz, r5.xyz);
  r5.w = rsqrt(r5.w);
  r6.xyz = r5.xyz * r5.www;
  r7.xyz = v1.xyz * v1.xyz;
  r5.xy = cb8[2].zz * cb2[12].zy;
  r6.w = saturate(cb3[49].w + cb2[13].z);
  r5.y = r6.w * r5.y;
  r6.w = saturate(r0.z * cb6[3].x + cb6[3].y);
  r6.w = sqrt(r6.w);
  r6.w = -r6.w * cb6[3].z + 1;
  r6.w = cb8[2].y * r6.w;
  r7.w = saturate(dot(r6.xyz, -cb3[0].xyz));
  r7.w = cb13[0].x + r7.w;
  r8.x = 1 + cb13[0].x;
  r8.x = r8.x * r8.x;
  r7.w = saturate(r7.w / r8.x);
  r8.yzw = r7.xyz * r7.www;
  r8.yzw = cb3[1].xyz * r8.yzw;
  o9.xyz = r8.yzw * r6.www;
  r6.w = cmp(0 >= asint(cb3[2].x));
  r7.w = cmp(cb3[19].w == 0.000000);
  r8.yzw = cb3[3].xyz + -r0.xyz;
  r9.xyz = -cb3[3].xyz + r0.xyz;
  r9.x = dot(r9.xyz, cb3[11].xyz);
  r9.y = 9.99999975e-05 + cb3[19].w;
  r9.x = saturate(r9.x / r9.y);
  r9.x = cb3[19].w * r9.x;
  r9.xyz = cb3[11].xyz * r9.xxx + cb3[3].xyz;
  r9.xyz = r9.xyz + -r0.xyz;
  r8.yzw = r7.www ? r8.yzw : r9.xyz;
  r7.w = dot(r8.yzw, r8.yzw);
  r8.yzw = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r8.yzw;
  r9.x = dot(r8.yzw, r8.yzw);
  r9.x = rsqrt(r9.x);
  r8.yzw = r9.xxx * r8.yzw;
  r7.w = saturate(-r7.w * cb3[3].w + 1);
  r9.x = 1 + -cb3[11].w;
  r9.x = r9.x * r7.w + cb3[11].w;
  r7.w = r7.w / r9.x;
  r9.x = dot(r8.yzw, -cb3[11].xyz);
  r9.x = saturate(r9.x * cb3[27].x + cb3[35].x);
  r8.y = saturate(dot(r8.yzw, r6.xyz));
  r8.y = cb13[0].x + r8.y;
  r8.y = saturate(r8.y / r8.x);
  r8.y = r8.y * r9.x;
  r7.w = r8.y * r7.w;
  r10.x = cmp(cb3[19].y < cb3[19].x);
  r10.y = 2.86520004 * cb3[19].y;
  r10.y = cmp(cb3[19].x < r10.y);
  r10.x = r10.y ? r10.x : 0;
  r10.y = 2.95910001 * cb3[19].z;
  r10.y = cmp(r10.y < cb3[19].y);
  r10.x = r10.y ? r10.x : 0;
  r10.xyz = r10.xxx ? cb3[19].yyy : cb3[19].xyz;
  r8.yzw = r10.xyz * r7.www;
  r8.yzw = r8.yzw * r7.xyz;
  r8.yzw = r6.www ? float3(0,0,0) : r8.yzw;
  r7.w = cmp(0 < asint(cb3[2].x));
  if (r7.w != 0) {
    r7.w = cmp(1 >= asint(cb3[2].x));
    r6.w = (int)r6.w | (int)r7.w;
    r7.w = cmp(cb3[20].w == 0.000000);
    r9.xyz = cb3[4].xyz + -r0.xyz;
    r10.xyz = -cb3[4].xyz + r0.xyz;
    r9.w = dot(r10.xyz, cb3[12].xyz);
    r10.x = 9.99999975e-05 + cb3[20].w;
    r9.w = saturate(r9.w / r10.x);
    r9.w = cb3[20].w * r9.w;
    r10.xyz = cb3[12].xyz * r9.www + cb3[4].xyz;
    r10.xyz = r10.xyz + -r0.xyz;
    r9.xyz = r7.www ? r9.xyz : r10.xyz;
    r7.w = dot(r9.xyz, r9.xyz);
    r9.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r9.xyz;
    r9.w = dot(r9.xyz, r9.xyz);
    r9.w = rsqrt(r9.w);
    r9.xyz = r9.xyz * r9.www;
    r7.w = saturate(-r7.w * cb3[4].w + 1);
    r9.w = 1 + -cb3[12].w;
    r9.w = r9.w * r7.w + cb3[12].w;
    r7.w = r7.w / r9.w;
    r9.w = dot(r9.xyz, -cb3[12].xyz);
    r9.w = saturate(r9.w * cb3[28].x + cb3[36].x);
    r9.x = saturate(dot(r9.xyz, r6.xyz));
    r9.x = cb13[0].x + r9.x;
    r9.x = saturate(r9.x / r8.x);
    r9.x = r9.x * r9.w;
    r7.w = r9.x * r7.w;
    r10.x = cmp(cb3[20].y < cb3[20].x);
    r10.y = 2.86520004 * cb3[20].y;
    r10.y = cmp(cb3[20].x < r10.y);
    r10.x = r10.y ? r10.x : 0;
    r10.y = 2.95910001 * cb3[20].z;
    r10.y = cmp(r10.y < cb3[20].y);
    r10.x = r10.y ? r10.x : 0;
    r10.xyz = r10.xxx ? cb3[20].yyy : cb3[20].xyz;
    r9.xyz = r10.xyz * r7.www;
    r9.xyz = r9.xyz * r7.xyz + r8.yzw;
    r8.yzw = r6.www ? r8.yzw : r9.xyz;
  } else {
    r6.w = -1;
  }
  if (r6.w == 0) {
    r7.w = cmp(2 >= asint(cb3[2].x));
    r6.w = (int)r6.w | (int)r7.w;
    r7.w = cmp(cb3[21].w == 0.000000);
    r9.xyz = cb3[5].xyz + -r0.xyz;
    r10.xyz = -cb3[5].xyz + r0.xyz;
    r9.w = dot(r10.xyz, cb3[13].xyz);
    r10.x = 9.99999975e-05 + cb3[21].w;
    r9.w = saturate(r9.w / r10.x);
    r9.w = cb3[21].w * r9.w;
    r10.xyz = cb3[13].xyz * r9.www + cb3[5].xyz;
    r10.xyz = r10.xyz + -r0.xyz;
    r9.xyz = r7.www ? r9.xyz : r10.xyz;
    r7.w = dot(r9.xyz, r9.xyz);
    r9.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r9.xyz;
    r9.w = dot(r9.xyz, r9.xyz);
    r9.w = rsqrt(r9.w);
    r9.xyz = r9.xyz * r9.www;
    r7.w = saturate(-r7.w * cb3[5].w + 1);
    r9.w = 1 + -cb3[13].w;
    r9.w = r9.w * r7.w + cb3[13].w;
    r7.w = r7.w / r9.w;
    r9.w = dot(r9.xyz, -cb3[13].xyz);
    r9.w = saturate(r9.w * cb3[29].x + cb3[37].x);
    r9.x = saturate(dot(r9.xyz, r6.xyz));
    r9.x = cb13[0].x + r9.x;
    r9.x = saturate(r9.x / r8.x);
    r9.x = r9.x * r9.w;
    r7.w = r9.x * r7.w;
    r10.x = cmp(cb3[21].y < cb3[21].x);
    r10.y = 2.86520004 * cb3[21].y;
    r10.y = cmp(cb3[21].x < r10.y);
    r10.x = r10.y ? r10.x : 0;
    r10.y = 2.95910001 * cb3[21].z;
    r10.y = cmp(r10.y < cb3[21].y);
    r10.x = r10.y ? r10.x : 0;
    r10.xyz = r10.xxx ? cb3[21].yyy : cb3[21].xyz;
    r9.xyz = r10.xyz * r7.www;
    r9.xyz = r9.xyz * r7.xyz + r8.yzw;
    r8.yzw = r6.www ? r8.yzw : r9.xyz;
  } else {
    r6.w = -1;
  }
  if (r6.w == 0) {
    r7.w = cmp(3 >= asint(cb3[2].x));
    r6.w = (int)r6.w | (int)r7.w;
    r7.w = cmp(cb3[22].w == 0.000000);
    r9.xyz = cb3[6].xyz + -r0.xyz;
    r10.xyz = -cb3[6].xyz + r0.xyz;
    r9.w = dot(r10.xyz, cb3[14].xyz);
    r10.x = 9.99999975e-05 + cb3[22].w;
    r9.w = saturate(r9.w / r10.x);
    r9.w = cb3[22].w * r9.w;
    r10.xyz = cb3[14].xyz * r9.www + cb3[6].xyz;
    r0.xyz = r10.xyz + -r0.xyz;
    r0.xyz = r7.www ? r9.xyz : r0.xyz;
    r7.w = dot(r0.xyz, r0.xyz);
    r0.xyz = float3(9.99999997e-07,9.99999997e-07,9.99999997e-07) + r0.xyz;
    r9.x = dot(r0.xyz, r0.xyz);
    r9.x = rsqrt(r9.x);
    r0.xyz = r9.xxx * r0.xyz;
    r7.w = saturate(-r7.w * cb3[6].w + 1);
    r9.x = 1 + -cb3[14].w;
    r9.x = r9.x * r7.w + cb3[14].w;
    r7.w = r7.w / r9.x;
    r9.x = dot(r0.xyz, -cb3[14].xyz);
    r9.x = saturate(r9.x * cb3[30].x + cb3[38].x);
    r0.x = saturate(dot(r0.xyz, r6.xyz));
    r0.x = cb13[0].x + r0.x;
    r0.x = saturate(r0.x / r8.x);
    r0.x = r0.x * r9.x;
    r0.x = r0.x * r7.w;
    r10.x = cmp(cb3[22].y < cb3[22].x);
    r10.y = 2.86520004 * cb3[22].y;
    r10.y = cmp(cb3[22].x < r10.y);
    r10.x = r10.y ? r10.x : 0;
    r10.y = 2.95910001 * cb3[22].z;
    r10.y = cmp(r10.y < cb3[22].y);
    r10.x = r10.y ? r10.x : 0;
    r10.xyz = r10.xxx ? cb3[22].yyy : cb3[22].xyz;
    r0.xyz = r10.xyz * r0.xxx;
    r0.xyz = r0.xyz * r7.xyz + r8.yzw;
    r8.yzw = r6.www ? r8.yzw : r0.xyz;
  }
  r0.x = r5.z * r5.w + cb3[43].w;
  r0.x = cb3[44].w * r0.x;
  r0.x = max(0, r0.x);
  r9.x = cmp(cb3[47].y < cb3[47].x);
  r9.y = 2.86520004 * cb3[47].y;
  r9.y = cmp(cb3[47].x < r9.y);
  r9.x = r9.y ? r9.x : 0;
  r9.y = 2.95910001 * cb3[47].z;
  r9.y = cmp(r9.y < cb3[47].y);
  r9.x = r9.y ? r9.x : 0;
  r9.xyz = r9.xxx ? cb3[47].yyy : cb3[47].xyz;
  r10.x = cmp(cb3[48].y < cb3[48].x);
  r10.y = 2.86520004 * cb3[48].y;
  r10.y = cmp(cb3[48].x < r10.y);
  r10.x = r10.y ? r10.x : 0;
  r10.y = 2.95910001 * cb3[48].z;
  r10.y = cmp(r10.y < cb3[48].y);
  r10.x = r10.y ? r10.x : 0;
  r10.xyz = r10.xxx ? cb3[48].yyy : cb3[48].xyz;
  r9.xyz = r9.xyz * r0.xxx + r10.xyz;
  r0.y = 1 + -cb2[13].z;
  r10.xyz = cb3[45].xyz * r0.xxx + cb3[46].xyz;
  r10.xyz = cb2[13].zzz * r10.xyz;
  r9.xyz = r9.xyz * r0.yyy + r10.xyz;
  r5.yzw = r9.xyz * r5.yyy;
  r0.xyz = cb3[43].xyz * r0.xxx + cb3[44].xyz;
  r9.x = cb3[46].w;
  r9.y = cb3[47].w;
  r9.z = cb3[48].w;
  r6.x = saturate(dot(r9.xyz, r6.xyz));
  r0.xyz = cb3[49].xyz * r6.xxx + r0.xyz;
  r0.xyz = r0.xyz * r5.xxx + r5.yzw;
  r0.xyz = r0.xyz * r7.xyz;
  o0.xyz = r8.yzw * cb8[3].xxx + r0.xyz;
  r0.x = -cb6[14].z * 1.5 + 1;
  r0.x = 0.5 * r0.x;
  r5.xyz = r2.xyz;
  r0.yz = float2(0,0);
  while (true) {
    r5.w = (int)r0.z;
    r5.w = cmp(r5.w >= 4);
    if (r5.w != 0) break;
    r6.xyz = -cb1[15].xyz + r5.xyz;
    r7.xyz = cb6[1].xyz * r6.yyy;
    r6.xyw = r6.xxx * cb6[0].xyz + r7.xyz;
    r6.xyz = r6.zzz * cb6[2].xyz + r6.xyw;
    r7.xyz = r6.xyz * cb6[4].xyz + cb6[8].xyz;
    x4[0].xyz = r7.xyz;
    r8.xyz = r6.xyz * cb6[5].xyz + cb6[9].xyz;
    x4[1].xyz = r8.xyz;
    r9.xyz = r6.xyz * cb6[6].xyz + cb6[10].xyz;
    x4[2].xyz = r9.xyz;
    r6.xyz = r6.xyz * cb6[7].xyz + cb6[11].xyz;
    x4[3].xyz = r6.xyz;
    r5.w = max(abs(r9.x), abs(r9.y));
    r5.w = cmp(r5.w < r0.x);
    r5.w = r5.w ? 2 : 3;
    r6.x = max(abs(r8.x), abs(r8.y));
    r6.x = cmp(r6.x < r0.x);
    r5.w = r6.x ? 1 : r5.w;
    r6.x = max(abs(r7.x), abs(r7.y));
    r6.x = cmp(r6.x < r0.x);
    r5.w = r6.x ? 0 : r5.w;
    r6.xyz = x4[r5.w+0].xyz;
    r5.w = (int)r5.w;
    r5.w = 0.5 + r5.w;
    r5.w = 0.25 * r5.w;
    r7.x = 0.5 + r6.x;
    r7.y = r6.y * 0.25 + r5.w;
    r5.w = t15.SampleCmpLevelZero(s15_s, r7.xy, r6.z).x;
    r0.y = r5.w + r0.y;
    r5.xyz = r1.xyz * float3(0.25,0.25,0.25) + r5.xyz;
    r0.z = (int)r0.z + 1;
  }
  r0.x = r0.y * 0.25 + -1;
  o7.z = v4.z * r0.x + 1;
  r0.x = v4.y * r2.w;
  o0.w = r1.w ? 0 : r0.x;
  r0.x = -cb3[50].x + r4.w;
  r0.x = max(0, r0.x);
  r0.y = r0.x / r4.w;
  r0.y = r4.z * r0.y;
  r0.z = cb3[52].z * r0.y;
  r0.y = cmp(0.00999999978 < abs(r0.y));
  r1.x = -1.44269502 * r0.z;
  r1.x = exp2(r1.x);
  r1.x = 1 + -r1.x;
  r0.z = r1.x / r0.z;
  r0.y = r0.y ? r0.z : 1;
  r0.z = cb3[51].w * r0.x;
  r0.y = r0.z * r0.y;
  r0.y = min(1, r0.y);
  r0.y = 1.44269502 * r0.y;
  r0.y = exp2(r0.y);
  r0.y = min(1, r0.y);
  r0.y = 1 + -r0.y;
  r0.z = cb3[52].y * r0.y;
  r0.w = rsqrt(r0.w);
  r1.xyz = r4.xyz * r0.www;
  r0.w = saturate(dot(r1.xyz, cb3[54].xyz));
  r0.w = log2(r0.w);
  r0.w = cb3[54].w * r0.w;
  r0.w = exp2(r0.w);
  r1.x = saturate(dot(r1.xyz, cb3[53].xyz));
  r1.x = log2(r1.x);
  r1.x = cb3[53].w * r1.x;
  r1.x = exp2(r1.x);
  r0.y = -r0.y * cb3[52].y + 1;
  r0.y = cb3[51].y * r0.y;
  r1.y = -cb3[52].x + r0.x;
  r1.y = max(0, r1.y);
  r1.y = cb3[51].x * r1.y;
  r1.y = 1.44269502 * r1.y;
  r1.y = exp2(r1.y);
  r1.y = 1 + -r1.y;
  o4.w = saturate(r0.y * r1.y + r0.z);
  r0.x = -cb3[51].z * r0.x;
  r0.x = 1.44269502 * r0.x;
  r0.x = exp2(r0.x);
  r0.x = 1 + -r0.x;
  r1.yzw = cb3[58].xyz + -cb3[56].xyz;
  r1.yzw = r0.www * r1.yzw + cb3[56].xyz;
  r2.xyz = cb3[55].xyz + -r1.yzw;
  r1.xyz = r1.xxx * r2.xyz + r1.yzw;
  r1.xyz = -cb3[57].xyz + r1.xyz;
  r0.xzw = r0.xxx * r1.xyz + cb3[57].xyz;
  r1.x = cb3[55].w + -r0.x;
  r1.y = cb3[56].w + -r0.z;
  r1.z = cb3[57].w + -r0.w;
  o4.xyz = r0.yyy * r1.xyz + r0.xzw;
  o12.x = dot(r3.xyzw, cb0[0].xyzw);
  o2.zw = float2(0,0);
  o5.x = v4.x;
  o5.yzw = v1.xyz;
  o6.xy = v5.xy;
  o6.zw = float2(0,0);
  o7.w = r3.w;
  o8.xyzw = float4(0,0,0,0);
  o10.xyzw = float4(0,0,0,0);
  o11.xyzw = r3.xyzw;
  o12.yzw = float3(0,0,0);
  o3.y = v3.y;
  return;
}