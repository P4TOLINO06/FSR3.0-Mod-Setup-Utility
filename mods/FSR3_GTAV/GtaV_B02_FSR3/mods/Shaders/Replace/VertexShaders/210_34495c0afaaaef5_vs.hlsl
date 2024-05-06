// ---- FNV Hash 34495c0afaaaef5

// ---- Created with 3Dmigoto v1.3.16 on Sun Nov 12 14:01:46 2023

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
  float4 v1 : COLOR0,
  float4 v2 : TEXCOORD0,
  float2 v3 : TEXCOORD1,
  float3 v4 : NORMAL0,
  float4 v5 : TANGENT0,
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
// unknown dcl_: dcl_input v1.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v4.xyz
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
    r0.x = r0.x ? r0.y : r6.w;
    r0.yz = r5.zw + r5.zw;
    r2.w = dot(r0.yz, r0.yz);
    r3.w = cmp(0 < r2.w);
    r2.w = sqrt(r2.w);
    r2.w = r3.w ? r2.w : 0;
    r3.w = -r2.w * 2 + 1;
    r5.z = max(-1, r3.w);
    r3.w = cmp(r5.z < 1);
    r4.w = cmp(-1 < r5.z);
    r3.w = r3.w ? r4.w : 0;
    r4.w = cmp(0 < r2.w);
    r3.w = r3.w ? r4.w : 0;
    r4.w = -r5.z * r5.z + 1;
    r4.w = sqrt(r4.w);
    r2.w = r4.w / r2.w;
    r2.w = r3.w ? r2.w : 0;
    r5.xy = r2.ww * r0.yz;
    r2.xyz = r2.xyz * r0.www;
    r2.xyz = DamageMultiplier * r2.xyz;
    r1.xyzw = float4(-0.492109388,-0.5,-0.5,-0.492109388) + r1.xyzw;
    r1.xyzw = r1.xyzw + r1.xyzw;
    r0.y = dot(r1.xy, r1.xy);
    r0.z = cmp(0 < r0.y);
    r0.y = sqrt(r0.y);
    r0.y = r0.z ? r0.y : 0;
    r0.z = -r0.y * 2 + 1;
    r7.z = max(-1, r0.z);
    r0.z = cmp(r7.z < 1);
    r2.w = cmp(-1 < r7.z);
    r0.z = r0.z ? r2.w : 0;
    r2.w = cmp(0 < r0.y);
    r0.z = r0.z ? r2.w : 0;
    r2.w = -r7.z * r7.z + 1;
    r2.w = sqrt(r2.w);
    r0.y = r2.w / r0.y;
    r0.y = r0.z ? r0.y : 0;
    r7.xy = r1.xy * r0.yy;
    r4.xyz = r4.xyz * r0.www;
    r7.xyz = r7.xyz + -r5.xyz;
    r4.xyz = r4.xyz * DamageMultiplier + -r2.xyz;
    r0.y = dot(r4.xyz, v4.xyz);
    r0.z = dot(r7.xyz, r7.xyz);
    r1.x = cmp(0 < r0.z);
    r4.x = r0.y / r0.z;
    r4.y = 1;
    r7.xyz = r4.xyx * r7.xyz;
    r4.z = r70.y;
    r4.xyz = r7.xyz * r4.zxz;
    r7.xz = float2(0.100000001,0.333299994);
    r7.y = r70.y;
    r4.xyz = r4.xyz * r7.xyz + v4.xyz;
    r4.xyz = r1.xxx ? r4.xyz : v4.xyz;
    r0.y = dot(r1.zw, r1.zw);
    r0.z = cmp(0 < r0.y);
    r0.y = sqrt(r0.y);
    r0.y = r0.z ? r0.y : 0;
    r0.z = -r0.y * 2 + 1;
    r8.z = max(-1, r0.z);
    r0.z = cmp(r8.z < 1);
    r1.x = cmp(-1 < r8.z);
    r0.z = r0.z ? r1.x : 0;
    r1.x = cmp(0 < r0.y);
    r0.z = r0.z ? r1.x : 0;
    r1.x = -r8.z * r8.z + 1;
    r1.x = sqrt(r1.x);
    r0.y = r1.x / r0.y;
    r0.y = r0.z ? r0.y : 0;
    r8.xy = r1.zw * r0.yy;
    r0.yzw = r3.xyz * r0.www;
    r1.xyz = r8.xyz + -r5.xyz;
    r0.yzw = r0.yzw * DamageMultiplier + -r2.xyz;
    r0.y = dot(r0.yzw, v4.xyz);
    r0.z = dot(r1.xyz, r1.xyz);
    r0.w = cmp(0 < r0.z);
    r2.x = r0.y / r0.z;
    r2.y = 1;
    r1.xyz = r2.xyx * r1.xyz;
    r2.z = r70.y;
    r1.xyz = r2.zxz * r1.xyz;
    r1.xyz = r1.xyz * r7.xyz + r4.xyz;
    r0.yzw = r0.www ? r1.xyz : r4.xyz;
    r0.yzw = float3(9.99999975e-05,9.99999975e-05,9.99999975e-05) + r0.yzw;
    r1.x = dot(r0.yzw, r0.yzw);
    r1.x = rsqrt(r1.x);
    r0.yzw = r1.xxx * r0.yzw;
  } else {
    r0.x = v0.y;
    r6.xz = v0.xz;
    r0.yzw = v4.xyz;
    o2.w = 1;
  }
  r1.xyz = gWorld._m10_m11_m12 * r0.xxx;
  r1.xyz = r6.xxx * gWorld._m00_m01_m02 + r1.xyz;
  r1.xyz = r6.zzz * gWorld._m20_m21_m22 + r1.xyz;
  r1.xyz = gWorld._m30_m31_m32 + r1.xyz;
  o4.xyz = gViewInverse._m30_m31_m32 + -r1.xyz;
  r1.xyz = gWorld._m10_m11_m12 * r0.zzz;
  r1.xyz = r0.yyy * gWorld._m00_m01_m02 + r1.xyz;
  o2.xyz = r0.www * gWorld._m20_m21_m22 + r1.xyz;
  if (bDebugDisplayDamageMap != 0) {
    r0.yzw = DamageTextureOffset.xyz + v0.xyz;
    r1.x = dot(r0.yzw, r0.yzw);
    r1.x = sqrt(r1.x);
    r0.yzw = r0.yzw / r1.xxx;
    r0.w = 1 + -r0.w;
    r0.w = 0.5 * r0.w;
    r1.y = dot(r0.yz, r0.yz);
    r1.y = max(9.99999994e-09, r1.y);
    r1.y = sqrt(r1.y);
    r0.yz = r0.yz / r1.yy;
    r0.yz = r0.yz * r0.ww;
    r0.yz = r0.yz * float2(0.5,0.5) + float2(0.5,0.5);
    r1.yz = float2(126.732697,126.732697) * r0.yz;
    r2.xy = cmp(r1.yz >= -r1.yz);
    r1.yz = frac(abs(r1.yz));
    r1.yz = r2.xy ? r1.yz : -r1.yz;
    r2.xyzw = DamageSampler.SampleLevel(DamageSampler_s, r0.yz, 0).xyzw;
    r0.yz = -r1.yz * float2(0.00789062493,0.00789062493) + r0.yz;
    r3.xyzw = float4(0.00789062493,0,0,0.00789062493) + r0.yzyz;
    r4.xyzw = DamageSampler.SampleLevel(DamageSampler_s, r3.xy, 0).xyzw;
    r3.xyzw = DamageSampler.SampleLevel(DamageSampler_s, r3.zw, 0).xyzw;
    r0.yz = float2(0.00789062493,0.00789062493) + r0.yz;
    r5.xyzw = DamageSampler.SampleLevel(DamageSampler_s, r0.yz, 0).xyzw;
    r0.yz = float2(1,1) + -r1.yz;
    r2.xyzw = r2.xyzw * r0.yyyy;
    r4.xyzw = r4.xyzw * r1.yyyy;
    r4.xyzw = r4.xyzw * r0.zzzz;
    r2.xyzw = r2.xyzw * r0.zzzz + r4.xyzw;
    r3.xyzw = r3.xyzw * r0.yyyy;
    r2.xyzw = r3.xyzw * r1.zzzz + r2.xyzw;
    r3.xyzw = r5.xyzw * r1.yyyy;
    r2.xyzw = r3.xyzw * r1.zzzz + r2.xyzw;
    r0.y = r1.x / BoundRadius;
    r0.y = min(1, r0.y);
    r1.xyzw = r2.xyzw * r0.yyyy;
    r1.xyzw = r1.xyzw * float4(0.5,0.5,0.5,0.5) + float4(0.5,0.5,0.5,0.5);
  } else {
    r1.xyzw = v1.xyzw;
  }
  r2.x = r70.y;
  r2.w = 1;
  o3.xyzw = bDebugDisplayDamageScale ? r2.xxxw : r1.xyzw;
  pos.xyzw = float4(r6.x, r0.x, r6.z, 1);
  r0.xyzw = gWorldViewProj._m10_m11_m12_m13 * r0.xxxx;
  r0.xyzw = r6.xxxx * gWorldViewProj._m00_m01_m02_m03 + r0.xyzw;
  r0.xyzw = r6.zzzz * gWorldViewProj._m20_m21_m22_m23 + r0.xyzw;
  o0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r0.xyzw;
  o1.xy = v2.xy;
  o1.zw = v3.xy;
  return;
}