// ---- FNV Hash 69edaa3f4e7a0524

// ---- Created with 3Dmigoto v1.3.16 on Fri Nov 10 16:42:30 2023

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
  float2 v3 : TEXCOORD0,
  float3 v4 : NORMAL0,
  float4 v5 : COLOR0,
  out float4 o0 : SV_Position0,
  out float4 o1 : TEXCOORD0,
  out float4 o2 : TEXCOORD1,
  out float4 o3 : TEXCOORD2,
  out float3 o4 : TEXCOORD3,
  out float4 pos : POSITION0)
{
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.z
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v4.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v5.xyzw
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8;
  uint4 bitmask, uiDest;
  float4 fDest;

  float4 r70;
  r70.xyzw = float4(1,1,1,1);
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
    r0.xy = float2(126.732697,126.732697) * r1.zw;
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
    o2.w = max(0, r2.w);
    r6.xyz = r0.xyz * r70.yyy + v0.xyz;
    r0.x = cmp(0 < DamagedWheelOffsets[0].w);
    r7.xyz = DamagedWheelOffsets[0].xyz + -DamageTextureOffset.xyz;
    r7.xzw = -r7.xyz + r6.xyz;
    r0.y = dot(r7.xzw, r7.xzw);
    r0.y = sqrt(r0.y);
    r0.z = 1.10000002 * DamagedWheelOffsets[0].w;
    r2.w = saturate(r0.y / r0.z);
    r3.w = cmp(r2.w < 1);
    r0.y = r7.z / r0.y;
    r2.w = r2.w * 0.100000001 + 0.899999976;
    r0.y = r2.w * r0.y;
    r0.y = r0.y * r0.z + r7.y;
    r0.y = r3.w ? r0.y : r6.y;
    r6.w = r0.x ? r0.y : r6.y;
    r0.x = cmp(0 < DamagedWheelOffsets[1].w);
    r7.xyz = DamagedWheelOffsets[1].xyz + -DamageTextureOffset.xyz;
    r7.xzw = -r7.xyz + r6.xwz;
    r0.y = dot(r7.xzw, r7.xzw);
    r0.y = sqrt(r0.y);
    r0.z = 1.10000002 * DamagedWheelOffsets[1].w;
    r2.w = saturate(r0.y / r0.z);
    r3.w = cmp(r2.w < 1);
    r0.y = r7.z / r0.y;
    r2.w = r2.w * 0.100000001 + 0.899999976;
    r0.y = r2.w * r0.y;
    r0.y = r0.y * r0.z + r7.y;
    r0.y = r3.w ? r0.y : r6.w;
    r6.y = r0.x ? r0.y : r6.w;
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
    r7.z = max(-1, r2.y);
    r2.y = cmp(r7.z < 1);
    r2.z = cmp(-1 < r7.z);
    r2.y = r2.z ? r2.y : 0;
    r2.z = cmp(0 < r2.x);
    r2.y = r2.z ? r2.y : 0;
    r2.z = -r7.z * r7.z + 1;
    r2.z = sqrt(r2.z);
    r2.x = r2.z / r2.x;
    r2.x = r2.y ? r2.x : 0;
    r7.xy = r2.xx * r1.xy;
    r2.xyz = r4.xyz * r0.www;
    r4.xyz = r7.xyz + -r5.xyz;
    r2.xyz = r2.xyz * DamageMultiplier + -r0.xyz;
    r1.x = dot(r2.xyz, v4.xyz);
    r1.y = dot(r4.xyz, r4.xyz);
    r2.x = cmp(0 < r1.y);
    r7.x = r1.x / r1.y;
    r7.y = 1;
    r2.yzw = r7.xyx * r4.xyz;
    r7.z = r70.y;
    r2.yzw = r7.zxz * r2.yzw;
    r4.xz = float2(0.100000001,0.333299994);
    r4.y = r70.y;
    r2.yzw = r2.yzw * r4.xyz + v4.xyz;
    r2.xyz = r2.xxx ? r2.yzw : v4.xyz;
    r1.x = dot(r1.zw, r1.zw);
    r1.y = cmp(0 < r1.x);
    r1.x = sqrt(r1.x);
    r1.x = r1.y ? r1.x : 0;
    r1.y = -r1.x * 2 + 1;
    r7.z = max(-1, r1.y);
    r1.y = cmp(r7.z < 1);
    r2.w = cmp(-1 < r7.z);
    r1.y = r1.y ? r2.w : 0;
    r2.w = cmp(0 < r1.x);
    r1.y = r1.y ? r2.w : 0;
    r2.w = -r7.z * r7.z + 1;
    r2.w = sqrt(r2.w);
    r1.x = r2.w / r1.x;
    r1.x = r1.y ? r1.x : 0;
    r7.xy = r1.zw * r1.xx;
    r1.xyz = r3.xyz * r0.www;
    r3.xyz = r7.xyz + -r5.xyz;
    r0.xyz = r1.xyz * DamageMultiplier + -r0.xyz;
    r0.x = dot(r0.xyz, v4.xyz);
    r0.y = dot(r3.xyz, r3.xyz);
    r0.z = cmp(0 < r0.y);
    r1.x = r0.x / r0.y;
    r1.y = 1;
    r0.xyw = r1.xyx * r3.xyz;
    r1.z = r70.y;
    r0.xyw = r1.zxz * r0.xyw;
    r0.xyw = r0.xyw * r4.xyz + r2.xyz;
    r0.xyz = r0.zzz ? r0.xyw : r2.xyz;
    r0.xyz = float3(9.99999975e-05,9.99999975e-05,9.99999975e-05) + r0.xyz;
    r0.w = dot(r0.xyz, r0.xyz);
    r0.w = rsqrt(r0.w);
    r0.xyz = r0.xyz * r0.www;
  } else {
    r6.xyz = v0.xyz;
    r0.xyz = v4.xyz;
    o2.w = 1;
  }
  r0.w = 255.001999 * v2.z;
  r0.w = (int)r0.w;
  r0.w = (int)r0.w * 3;
  r6.w = 1;
  r1.x = dot(gBoneMtx[r0.w/3]._m00_m01_m02_m03, r6.xyzw);
  r1.y = dot(gBoneMtx[r0.w/3]._m10_m11_m12_m13, r6.xyzw);
  r1.z = dot(gBoneMtx[r0.w/3]._m20_m21_m22_m23, r6.xyzw);
  r2.xyz = gWorld._m10_m11_m12 * r1.yyy;
  r2.xyz = r1.xxx * gWorld._m00_m01_m02 + r2.xyz;
  r2.xyz = r1.zzz * gWorld._m20_m21_m22 + r2.xyz;
  r2.xyz = gWorld._m30_m31_m32 + r2.xyz;
  o4.xyz = gViewInverse._m30_m31_m32 + -r2.xyz;
  r1.w = dot(gBoneMtx[r0.w/3]._m00_m01_m02, r0.xyz);
  r2.x = dot(gBoneMtx[r0.w/3]._m10_m11_m12, r0.xyz);
  r0.x = dot(gBoneMtx[r0.w/3]._m20_m21_m22, r0.xyz);
  r0.yzw = gWorld._m10_m11_m12 * r2.xxx;
  r0.yzw = r1.www * gWorld._m00_m01_m02 + r0.yzw;
  o2.xyz = r0.xxx * gWorld._m20_m21_m22 + r0.yzw;
  pos.xyzw = float4(r1.xyz, 1);
  r0.xyzw = gWorldViewProj._m10_m11_m12_m13 * r1.yyyy;
  r0.xyzw = r1.xxxx * gWorldViewProj._m00_m01_m02_m03 + r0.xyzw;
  r0.xyzw = r1.zzzz * gWorldViewProj._m20_m21_m22_m23 + r0.xyzw;
  o0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r0.xyzw;
  if (bDebugDisplayDamageMap != 0) {
    r0.xyz = DamageTextureOffset.xyz + v0.xyz;
    r0.w = dot(r0.xyz, r0.xyz);
    r0.w = sqrt(r0.w);
    r0.xyz = r0.xyz / r0.www;
    r0.z = 1 + -r0.z;
    r0.z = 0.5 * r0.z;
    r1.x = dot(r0.xy, r0.xy);
    r1.x = max(9.99999994e-09, r1.x);
    r1.x = sqrt(r1.x);
    r0.xy = r0.xy / r1.xx;
    r0.xy = r0.xy * r0.zz;
    r0.xy = r0.xy * float2(0.5,0.5) + float2(0.5,0.5);
    r1.xy = float2(126.732697,126.732697) * r0.xy;
    r1.zw = cmp(r1.xy >= -r1.xy);
    r1.xy = frac(abs(r1.xy));
    r1.xy = r1.zw ? r1.xy : -r1.xy;
    r2.xyzw = DamageSampler.SampleLevel(DamageSampler_s, r0.xy, 0).xyzw;
    r0.xy = -r1.xy * float2(0.00789062493,0.00789062493) + r0.xy;
    r3.xyzw = float4(0.00789062493,0,0,0.00789062493) + r0.xyxy;
    r4.xyzw = DamageSampler.SampleLevel(DamageSampler_s, r3.xy, 0).xyzw;
    r3.xyzw = DamageSampler.SampleLevel(DamageSampler_s, r3.zw, 0).xyzw;
    r0.xy = float2(0.00789062493,0.00789062493) + r0.xy;
    r5.xyzw = DamageSampler.SampleLevel(DamageSampler_s, r0.xy, 0).xyzw;
    r0.xy = float2(1,1) + -r1.xy;
    r2.xyzw = r2.xyzw * r0.xxxx;
    r4.xyzw = r4.xyzw * r1.xxxx;
    r4.xyzw = r4.xyzw * r0.yyyy;
    r2.xyzw = r2.xyzw * r0.yyyy + r4.xyzw;
    r3.xyzw = r3.xyzw * r0.xxxx;
    r2.xyzw = r3.xyzw * r1.yyyy + r2.xyzw;
    r3.xyzw = r5.xyzw * r1.xxxx;
    r1.xyzw = r3.xyzw * r1.yyyy + r2.xyzw;
    r0.x = r0.w / BoundRadius;
    r0.x = min(1, r0.x);
    r0.xyzw = r1.xyzw * r0.xxxx;
    r0.xyzw = r0.xyzw * float4(0.5,0.5,0.5,0.5) + float4(0.5,0.5,0.5,0.5);
  } else {
    r0.xyzw = v5.xyzw;
  }
  r1.x = r70.y;
  r1.w = 1;
  o3.xyzw = bDebugDisplayDamageScale ? r1.xxxw : r0.xyzw;
  o1.xy = v3.xy;
  return;
}