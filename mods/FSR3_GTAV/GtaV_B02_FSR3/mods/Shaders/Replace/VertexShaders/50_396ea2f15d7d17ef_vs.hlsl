// ---- FNV Hash 396ea2f15d7d17ef

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov  4 12:47:49 2023

cbuffer rage_bonemtx : register(b4)
{
  row_major float3x4 gBoneMtx[255] : packoffset(c0);
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

cbuffer vehicle_globals : register(b7)
{
  bool switchOn : packoffset(c0);
  bool tyreDeformSwitchOn : packoffset(c0.y);
}

cbuffer vehicle_damage_locals : register(b12)
{
  float BoundRadius : packoffset(c0);
  float DamageMultiplier : packoffset(c0.y);
  float3 DamageTextureOffset : packoffset(c1);
  float4 DamagedWheelOffsets[2] : packoffset(c2);
  bool bDebugDisplayDamageMap : packoffset(c4);
  bool bDebugDisplayDamageScale : packoffset(c4.y);
}

SamplerState DamageSampler_s : register(s2);
Texture2D<float4> DamageSampler : register(t2);


// 3Dmigoto declarations
#define cmp -


void main(
  float3 v0 : POSITION0,
  float4 v1 : BLENDWEIGHT0,
  float4 v2 : BLENDINDICES0,
  float4 v3 : TEXCOORD0,
  float2 v4 : TEXCOORD1,
  float3 v5 : NORMAL0,
  float4 v6 : TANGENT0,
  float4 v7 : COLOR0,
  out float4 o0 : SV_Position0,
  out float4 o1 : TEXCOORD0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD2,
  out float4 o4 : TEXCOORD3,
  out float4 o5 : TEXCOORD4,
  out float3 o6 : TEXCOORD5,
  out float4 pos : POSITION0)
{
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
// unknown dcl_: dcl_input v6.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v7.xyzw
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8;
  uint4 bitmask, uiDest;
  float4 fDest;

  if (switchOn != 0) {
    r0.xyz = DamageTextureOffset.xyz + v0.xyz;
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
    r0.xy = float2(126.732674,126.732674) * r1.zw;
    r2.xy = cmp(r0.xy >= -r0.xy);
    r0.xy = frac(abs(r0.xy));
    r0.xy = r2.xy ? r0.xy : -r0.xy;
    r2.xyzw = DamageSampler.SampleLevel(DamageSampler_s, r1.zw, 0).xyzw;
    r1.xyzw = -r0.xyxy * float4(0.00789062493,0.00789062493,0.00789062493,0.00789062493) + r1.xyzw;
    r3.xyzw = float4(0.00789062493,0,0,0.00789062493) + r1.zwzw;
    r4.xyzw = DamageSampler.SampleLevel(DamageSampler_s, r3.xy, 0).xyzw;
    r3.xyzw = DamageSampler.SampleLevel(DamageSampler_s, r3.zw, 0).xyzw;
    r5.xyzw = float4(0.00789062493,0.00789062493,-0.5,-0.5) + r1.zwzw;
    r6.xyzw = DamageSampler.SampleLevel(DamageSampler_s, r5.xy, 0).xyzw;
    r5.xy = float2(1,1) + -r0.xy;
    r7.xyz = r5.xxx * r2.xyz;
    r8.xyz = r4.xyz * r0.xxx;
    r8.xyz = r8.xyz * r5.yyy;
    r7.xyz = r7.xyz * r5.yyy + r8.xyz;
    r8.xyz = r5.xxx * r3.xyz;
    r7.xyz = r8.xyz * r0.yyy + r7.xyz;
    r6.xyz = r6.xyz * r0.xxx;
    r0.xyz = r6.xyz * r0.yyy + r7.xyz;
    r0.w = r0.w / BoundRadius;
    r0.w = min(1, r0.w);
    r0.xyz = r0.xyz * r0.www;
    r0.xyz = DamageMultiplier * r0.xyz;
    r2.w = dot(r0.xyz, r0.xyz);
    r2.w = sqrt(r2.w);
    r2.w = min(1, r2.w);
    r2.w = -r2.w * 4 + 1;
    r6.w = max(0, r2.w);
    r7.xyz = r0.xyz * v7.yyy + v0.xyz;
    r0.x = cmp(0 < DamagedWheelOffsets[0].w);
    r8.xyz = DamagedWheelOffsets[0].xyz + -DamageTextureOffset.xyz;
    r8.xzw = -r8.xyz + r7.xyz;
    r0.y = dot(r8.xzw, r8.xzw);
    r0.y = sqrt(r0.y);
    r0.z = 1.10000002 * DamagedWheelOffsets[0].w;
    r2.w = saturate(r0.y / r0.z);
    r3.w = cmp(r2.w < 1);
    r0.y = r8.z / r0.y;
    r2.w = r2.w * 0.100000001 + 0.899999976;
    r0.y = r2.w * r0.y;
    r0.y = r0.y * r0.z + r8.y;
    r0.y = r3.w ? r0.y : r7.y;
    r7.w = r0.x ? r0.y : r7.y;
    r0.x = cmp(0 < DamagedWheelOffsets[1].w);
    r8.xyz = DamagedWheelOffsets[1].xyz + -DamageTextureOffset.xyz;
    r8.xzw = -r8.xyz + r7.xwz;
    r0.y = dot(r8.xzw, r8.xzw);
    r0.y = sqrt(r0.y);
    r0.z = 1.10000002 * DamagedWheelOffsets[1].w;
    r2.w = saturate(r0.y / r0.z);
    r3.w = cmp(r2.w < 1);
    r0.y = r8.z / r0.y;
    r2.w = r2.w * 0.100000001 + 0.899999976;
    r0.y = r2.w * r0.y;
    r0.y = r0.y * r0.z + r8.y;
    r0.y = r3.w ? r0.y : r7.w;
    r7.y = r0.x ? r0.y : r7.w;
    r0.xy = r5.zw + r5.zw;
    r0.z = dot(r0.xy, r0.xy);
    r2.w = cmp(0 < r0.z);
    r0.z = sqrt(r0.z);
    r0.z = r2.w ? r0.z : 0;
    r2.w = -r0.z * 2 + 1;
    r5.z = max(-1, r2.w);
    r2.w = cmp(r5.z < 1);
    r3.w = cmp(-1 < r5.z);
    r2.w = r2.w ? r3.w : 0;
    r3.w = cmp(0 < r0.z);
    r2.w = r2.w ? r3.w : 0;
    r3.w = -r5.z * r5.z + 1;
    r3.w = sqrt(r3.w);
    r0.z = r3.w / r0.z;
    r0.z = r2.w ? r0.z : 0;
    r5.xy = r0.xy * r0.zz;
    r0.xyz = r2.xyz * r0.www;
    r0.xyz = DamageMultiplier * r0.xyz;
    r1.xyzw = float4(-0.492109388,-0.5,-0.5,-0.492109388) + r1.xyzw;
    r1.xyzw = r1.xyzw + r1.xyzw;
    r2.x = dot(r1.xy, r1.xy);
    r2.y = cmp(0 < r2.x);
    r2.x = sqrt(r2.x);
    r2.x = r2.y ? r2.x : 0;
    r2.y = -r2.x * 2 + 1;
    r8.z = max(-1, r2.y);
    r2.y = cmp(r8.z < 1);
    r2.z = cmp(-1 < r8.z);
    r2.y = r2.z ? r2.y : 0;
    r2.z = cmp(0 < r2.x);
    r2.y = r2.z ? r2.y : 0;
    r2.z = -r8.z * r8.z + 1;
    r2.z = sqrt(r2.z);
    r2.x = r2.z / r2.x;
    r2.x = r2.y ? r2.x : 0;
    r8.xy = r2.xx * r1.xy;
    r2.xyz = r4.xyz * r0.www;
    r4.xyz = r8.xyz + -r5.xyz;
    r2.xyz = r2.xyz * DamageMultiplier + -r0.xyz;
    r1.x = dot(r2.xyz, v5.xyz);
    r1.y = dot(r4.xyz, r4.xyz);
    r2.x = cmp(0 < r1.y);
    r8.x = r1.x / r1.y;
    r8.y = 1;
    r2.yzw = r8.xyx * r4.xyz;
    r8.z = v7.y;
    r2.yzw = r8.zxz * r2.yzw;
    r4.xz = float2(0.100000001,0.333299994);
    r4.y = v7.y;
    r2.yzw = r2.yzw * r4.xyz + v5.xyz;
    r2.xyz = r2.xxx ? r2.yzw : v5.xyz;
    r1.x = dot(r1.zw, r1.zw);
    r1.y = cmp(0 < r1.x);
    r1.x = sqrt(r1.x);
    r1.x = r1.y ? r1.x : 0;
    r1.y = -r1.x * 2 + 1;
    r8.z = max(-1, r1.y);
    r1.y = cmp(r8.z < 1);
    r2.w = cmp(-1 < r8.z);
    r1.y = r1.y ? r2.w : 0;
    r2.w = cmp(0 < r1.x);
    r1.y = r1.y ? r2.w : 0;
    r2.w = -r8.z * r8.z + 1;
    r2.w = sqrt(r2.w);
    r1.x = r2.w / r1.x;
    r1.x = r1.y ? r1.x : 0;
    r8.xy = r1.zw * r1.xx;
    r1.xyz = r3.xyz * r0.www;
    r3.xyz = r8.xyz + -r5.xyz;
    r0.xyz = r1.xyz * DamageMultiplier + -r0.xyz;
    r0.x = dot(r0.xyz, v5.xyz);
    r0.y = dot(r3.xyz, r3.xyz);
    r0.z = cmp(0 < r0.y);
    r1.x = r0.x / r0.y;
    r1.y = 1;
    r0.xyw = r1.xyx * r3.xyz;
    r1.z = v7.y;
    r0.xyw = r1.zxz * r0.xyw;
    r0.xyw = r0.xyw * r4.xyz + r2.xyz;
    r0.xyz = r0.zzz ? r0.xyw : r2.xyz;
    r0.xyz = float3(9.99999975e-05,9.99999975e-05,9.99999975e-05) + r0.xyz;
    r0.w = dot(r0.xyz, r0.xyz);
    r0.w = rsqrt(r0.w);
    r0.xyz = r0.xyz * r0.www;
  } else {
    r7.xyz = v0.xyz;
    r0.xyz = v5.xyz;
    r6.w = 1;
  }
  r0.w = 255.001953 * v2.z;
  r0.w = (int)r0.w;
  r0.w = (int)r0.w * 3;
  r7.w = 1;
  r1.x = dot(gBoneMtx[r0.w/3]._m00_m01_m02_m03, r7.xyzw);
  r1.y = dot(gBoneMtx[r0.w/3]._m10_m11_m12_m13, r7.xyzw);
  r1.z = dot(gBoneMtx[r0.w/3]._m20_m21_m22_m23, r7.xyzw);
  r2.xyz = gWorld._m10_m11_m12 * r1.yyy;
  r2.xyz = r1.xxx * gWorld._m00_m01_m02 + r2.xyz;
  r2.xyz = r1.zzz * gWorld._m20_m21_m22 + r2.xyz;
  r2.xyz = gWorld._m30_m31_m32 + r2.xyz;
  o4.xyz = gViewInverse._m30_m31_m32 + -r2.xyz;
  r1.w = dot(gBoneMtx[r0.w/3]._m00_m01_m02, r0.xyz);
  r2.x = dot(gBoneMtx[r0.w/3]._m10_m11_m12, r0.xyz);
  r0.x = dot(gBoneMtx[r0.w/3]._m20_m21_m22, r0.xyz);
  r2.xyz = gWorld._m10_m11_m12 * r2.xxx;
  r2.xyz = r1.www * gWorld._m00_m01_m02 + r2.xyz;
  r6.xyz = r0.xxx * gWorld._m20_m21_m22 + r2.xyz;
  r0.x = dot(gBoneMtx[r0.w/3]._m00_m01_m02, v6.xyz);
  r0.y = dot(gBoneMtx[r0.w/3]._m10_m11_m12, v6.xyz);
  r0.z = dot(gBoneMtx[r0.w/3]._m20_m21_m22, v6.xyz);
  r2.xyz = gWorld._m10_m11_m12 * r0.yyy;
  r0.xyw = r0.xxx * gWorld._m00_m01_m02 + r2.xyz;
  r0.xyz = r0.zzz * gWorld._m20_m21_m22 + r0.xyw;
  r2.xyz = r0.zxy * r6.yzx;
  r2.xyz = r0.yzx * r6.zxy + -r2.xyz;
  o6.xyz = v6.www * r2.xyz;
  pos.xyzw = float4(r1.xyz, 1);
  r2.xyzw = gWorldViewProj._m10_m11_m12_m13 * r1.yyyy;
  r2.xyzw = r1.xxxx * gWorldViewProj._m00_m01_m02_m03 + r2.xyzw;
  r1.xyzw = r1.zzzz * gWorldViewProj._m20_m21_m22_m23 + r2.xyzw;
  o0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r1.xyzw;
  if (bDebugDisplayDamageMap != 0) {
    r1.xyz = DamageTextureOffset.xyz + v0.xyz;
    r0.w = dot(r1.xyz, r1.xyz);
    r0.w = sqrt(r0.w);
    r1.xyz = r1.xyz / r0.www;
    r1.z = 1 + -r1.z;
    r1.z = 0.5 * r1.z;
    r1.w = dot(r1.xy, r1.xy);
    r1.w = max(9.99999994e-09, r1.w);
    r1.w = sqrt(r1.w);
    r1.xy = r1.xy / r1.ww;
    r1.xy = r1.xy * r1.zz;
    r1.xy = r1.xy * float2(0.5,0.5) + float2(0.5,0.5);
    r1.zw = float2(126.732674,126.732674) * r1.xy;
    r2.xy = cmp(r1.zw >= -r1.zw);
    r1.zw = frac(abs(r1.zw));
    r1.zw = r2.xy ? r1.zw : -r1.zw;
    r2.xyzw = DamageSampler.SampleLevel(DamageSampler_s, r1.xy, 0).xyzw;
    r1.xy = -r1.zw * float2(0.00789062493,0.00789062493) + r1.xy;
    r3.xyzw = float4(0.00789062493,0,0,0.00789062493) + r1.xyxy;
    r4.xyzw = DamageSampler.SampleLevel(DamageSampler_s, r3.xy, 0).xyzw;
    r3.xyzw = DamageSampler.SampleLevel(DamageSampler_s, r3.zw, 0).xyzw;
    r1.xy = float2(0.00789062493,0.00789062493) + r1.xy;
    r5.xyzw = DamageSampler.SampleLevel(DamageSampler_s, r1.xy, 0).xyzw;
    r1.xy = float2(1,1) + -r1.zw;
    r2.xyzw = r2.xyzw * r1.xxxx;
    r4.xyzw = r4.xyzw * r1.zzzz;
    r4.xyzw = r4.xyzw * r1.yyyy;
    r2.xyzw = r2.xyzw * r1.yyyy + r4.xyzw;
    r3.xyzw = r3.xyzw * r1.xxxx;
    r2.xyzw = r3.xyzw * r1.wwww + r2.xyzw;
    r3.xyzw = r5.xyzw * r1.zzzz;
    r1.xyzw = r3.xyzw * r1.wwww + r2.xyzw;
    r0.w = r0.w / BoundRadius;
    r0.w = min(1, r0.w);
    r1.xyzw = r1.xyzw * r0.wwww;
    r1.xyzw = r1.xyzw * float4(0.5,0.5,0.5,0.5) + float4(0.5,0.5,0.5,0.5);
  } else {
    r1.xyzw = v7.xyzw;
  }
  r2.x = v7.y;
  r2.w = 1;
  o3.xyzw = bDebugDisplayDamageScale ? r2.xxxw : r1.xyzw;
  o1.xy = v3.xy;
  o1.zw = v4.xy;
  o2.xyzw = r6.xyzw;
  o5.xyz = r0.xyz;
  return;
}