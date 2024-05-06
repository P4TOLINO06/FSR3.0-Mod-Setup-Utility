// ---- FNV Hash 782b6604b681f4f5

// ---- Created with 3Dmigoto v1.3.16 on Mon Nov 20 02:46:44 2023
Texture2D<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb5 : register(b5)
{
  float4 cb5[3];
}

cbuffer cb3 : register(b3)
{
  float4 cb3[53];
}

cbuffer cb2 : register(b2)
{
  float4 cb2[16];
}

cbuffer cb1 : register(b1)
{
  float4 cb1[16];
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
  float2 v2 : TEXCOORD0,
  float3 v3 : NORMAL0,
  uint v4 : SV_InstanceID0,
  out float4 o0 : SV_Position0,
  out float4 o1 : TEXCOORD0,
  out float3 o2 : TEXCOORD1,
  out float4 pos : POSITION0)
{
  const float4 icb[] = { { 0.772968, -0.222156, 0.528241, -0.802848},
                              { 0.262963, -0.075235, 0.823705, -0.556188},
                              { 0.569683, 0.121086, 0.398884, -0.411417},
                              { 0.440016, 0.487990, -0.034640, 0.176342},
                              { -0.120323, -0.586049, 0.200466, -0.687419},
                              { -0.258614, -0.163080, -0.688321, -0.635556},
                              { -0.345086, -0.848096, -0.362813, 0.614420},
                              { 0.061750, 0.506920, 0.977316, 0.208662},
                              { 0.789433, 0.490265, -0.702313, -0.071461},
                              { -0.495341, 0.233821, 0.179311, 0.962585},
                              { -0.930975, -0.327397, -0.912985, 0.241697},
                              { -0.217266, 0.972708, -0.697119, 0.529669} };
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.xyz
  float4 r0,r1,r2,r3;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xyz = cb1[9].xyw * v3.yyy;
  r0.xyz = v3.xxx * cb1[8].xyw + r0.xyz;
  r0.xyz = v3.zzz * cb1[10].xyw + r0.xyz;
  r0.xyz = cb1[11].xyw + r0.xyz;
  r0.w = 1 / r0.z;
  r0.xy = r0.xy * r0.ww;
  r1.xy = r0.xy * float2(0.5,-0.5) + float2(0.5,0.5);
  r1.xyzw = t0.SampleLevel(s0_s, r1.xy, 0).xyzw;
  r1.x = cmp(r1.x >= r0.z);
  if (r1.x != 0) {
    r1.xy = cb1[9].xy * v0.yy;
    r1.xy = v0.xx * cb1[8].xy + r1.xy;
    r1.xy = v0.zz * cb1[10].xy + r1.xy;
    r1.xy = cb1[11].xy + r1.xy;
    r1.xy = r1.xy * r0.ww + -r0.xy;
    r0.w = dot(r1.xy, r1.xy);
    r0.w = sqrt(r0.w);
    r0.w = cb5[2].x * r0.w;
    r1.x = dot(cb5[2].yy, cb2[15].zz);
    r0.w = min(r1.x, r0.w);
    r1.xy = float2(0,0);
    while (true) {
      r1.z = cmp((int)r1.y >= 12);
      if (r1.z != 0) break;
      r2.xyzw = icb[r1.y+0].xyzw * r0.wwww + r0.xyxy;
      r2.xyzw = r2.xyzw * float4(0.5,-0.5,0.5,-0.5) + float4(0.5,0.5,0.5,0.5);
      r3.xyzw = t0.SampleLevel(s0_s, r2.xy, 0).xyzw;
      r1.z = cmp(r3.x >= r0.z);
      r1.z = r1.z ? 1.000000 : 0;
      r1.z = r1.x + r1.z;
      r2.xyzw = t0.SampleLevel(s0_s, r2.zw, 0).xyzw;
      r1.w = cmp(r2.x >= r0.z);
      r1.w = r1.w ? 1.000000 : 0;
      r1.x = r1.z + r1.w;
      r1.y = (int)r1.y + 1;
    }
  } else {
    r1.x = 0;
  }
  r0.z = 0.0416666716 * r1.x;
  r0.w = 1.00010002 + -cb5[1].x;
  r0.w = 1 / r0.w;
  r0.xy = saturate(-cb5[1].xx + abs(r0.xy));
  r0.x = max(r0.x, r0.y);
  r0.x = saturate(r0.x * r0.w);
  r0.x = 1 + -r0.x;
  r0.xz = r0.xz * r0.xz;
  r0.x = r0.z * r0.x;
  r0.y = cmp(0 < r0.x);
  r0.yzw = r0.yyy ? v0.xyz : v3.xyz;
  pos.xyzw = float4(r0.y, r0.z, r0.w, 1);
  r1.xyzw = cb1[9].xyzw * r0.zzzz;
  r1.xyzw = r0.yyyy * cb1[8].xyzw + r1.xyzw;
  r1.xyzw = r0.wwww * cb1[10].xyzw + r1.xyzw;
  o0.xyzw = cb1[11].xyzw + r1.xyzw;
  r0.xyz = v1.xyz * r0.xxx;
  r0.xyz = v2.yyy * r0.xyz;
  r1.xyz = -cb1[15].xyz + v0.xyz;
  r0.w = dot(r1.xyz, r1.xyz);
  r0.w = sqrt(r0.w);
  r1.x = -cb3[50].x + r0.w;
  r1.x = max(0, r1.x);
  r0.w = r1.x / r0.w;
  r0.w = r1.z * r0.w;
  r1.y = cb3[52].z * r0.w;
  r0.w = cmp(0.00999999978 < abs(r0.w));
  r1.z = -1.44269502 * r1.y;
  r1.z = exp2(r1.z);
  r1.z = 1 + -r1.z;
  r1.y = r1.z / r1.y;
  r0.w = r0.w ? r1.y : 1;
  r1.y = cb3[51].w * r1.x;
  r0.w = r1.y * r0.w;
  r0.w = min(1, r0.w);
  r0.w = 1.44269502 * r0.w;
  r0.w = exp2(r0.w);
  r0.w = min(1, r0.w);
  r0.w = 1 + -r0.w;
  r1.y = cb3[52].y * r0.w;
  r0.w = -r0.w * cb3[52].y + 1;
  r0.w = cb3[51].y * r0.w;
  r1.x = -cb3[52].x + r1.x;
  r1.x = max(0, r1.x);
  r1.x = cb3[51].x * r1.x;
  r1.x = 1.44269502 * r1.x;
  r1.x = exp2(r1.x);
  r1.x = 1 + -r1.x;
  r0.w = saturate(r0.w * r1.x + r1.y);
  r0.w = 1 + -r0.w;
  r0.xyz = float3(0.0199999996,0.0199999996,0.0199999996) * r0.xyz;
  o2.xyz = r0.xyz * r0.www;
  o1.x = v2.x;
  o1.y = v1.w;
  return;
}