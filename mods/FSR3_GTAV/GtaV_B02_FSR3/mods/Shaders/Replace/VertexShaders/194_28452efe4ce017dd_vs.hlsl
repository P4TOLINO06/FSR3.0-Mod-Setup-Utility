// ---- FNV Hash 28452efe4ce017dd

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov 11 18:22:15 2023

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

cbuffer rage_clipplanes : register(b0)
{
  float4 ClipPlanes : packoffset(c0);
}

cbuffer lighting_globals : register(b3)
{
  float4 gDirectionalLight : packoffset(c0);
  float4 gDirectionalColour : packoffset(c1);
  int gNumForwardLights : packoffset(c2);
  float4 gLightPositionAndInvDistSqr[8] : packoffset(c3);
  float4 gLightDirectionAndFalloffExponent[8] : packoffset(c11);
  float4 gLightColourAndCapsuleExtent[8] : packoffset(c19);
  float gLightConeScale[8] : packoffset(c27);
  float gLightConeOffset[8] : packoffset(c35);
  float4 gLightNaturalAmbient0 : packoffset(c43);
  float4 gLightNaturalAmbient1 : packoffset(c44);
  float4 gLightArtificialIntAmbient0 : packoffset(c45);
  float4 gLightArtificialIntAmbient1 : packoffset(c46);
  float4 gLightArtificialExtAmbient0 : packoffset(c47);
  float4 gLightArtificialExtAmbient1 : packoffset(c48);
  float4 gDirectionalAmbientColour : packoffset(c49);
  float4 globalFogParams[5] : packoffset(c50);
  float4 globalFogColor : packoffset(c55);
  float4 globalFogColorE : packoffset(c56);
  float4 globalFogColorN : packoffset(c57);
  float4 globalFogColorMoon : packoffset(c58);
  float4 gReflectionTweaks : packoffset(c59);
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
  float4 v3 : TEXCOORD1,
  float2 v4 : TEXCOORD2,
  float3 v5 : NORMAL0,
  float4 v6 : TANGENT0,
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
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v0.xyz
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v1.xyzw
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v2.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v3.xy
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v4.x
// Needs manual fix for instruction:
// unknown dcl_: dcl_input v5.xyz
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
    o1.w = max(0, r2.w);
    r6.xyz = r0.xyz * v4.xxx + v0.xyz;
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
    r0.y = dot(r4.xyz, v5.xyz);
    r0.z = dot(r7.xyz, r7.xyz);
    r1.x = cmp(0 < r0.z);
    r4.x = r0.y / r0.z;
    r4.y = 1;
    r7.xyz = r4.xyx * r7.xyz;
    r4.z = v4.x;
    r4.xyz = r7.xyz * r4.zxz;
    r7.xz = float2(0.100000001,0.333299994);
    r7.y = v4.x;
    r4.xyz = r4.xyz * r7.xyz + v5.xyz;
    r4.xyz = r1.xxx ? r4.xyz : v5.xyz;
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
    r0.y = dot(r0.yzw, v5.xyz);
    r0.z = dot(r1.xyz, r1.xyz);
    r0.w = cmp(0 < r0.z);
    r2.x = r0.y / r0.z;
    r2.y = 1;
    r1.xyz = r2.xyx * r1.xyz;
    r2.z = v4.x;
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
    r0.yzw = v5.xyz;
    o1.w = 1;
  }
  r1.xyz = gWorld._m10_m11_m12 * r0.xxx;
  r1.xyz = r6.xxx * gWorld._m00_m01_m02 + r1.xyz;
  r1.xyz = r6.zzz * gWorld._m20_m21_m22 + r1.xyz;
  r1.xyz = gWorld._m30_m31_m32 + r1.xyz;
  o3.xyz = gViewInverse._m30_m31_m32 + -r1.xyz;
  r2.xyz = gWorld._m10_m11_m12 * r0.zzz;
  r2.xyz = r0.yyy * gWorld._m00_m01_m02 + r2.xyz;
  o1.xyz = r0.www * gWorld._m20_m21_m22 + r2.xyz;
  if (bDebugDisplayDamageMap != 0) {
    r0.yzw = DamageTextureOffset.xyz + v0.xyz;
    r1.w = dot(r0.yzw, r0.yzw);
    r1.w = sqrt(r1.w);
    r0.yzw = r0.yzw / r1.www;
    r0.w = 1 + -r0.w;
    r0.w = 0.5 * r0.w;
    r2.x = dot(r0.yz, r0.yz);
    r2.x = max(9.99999994e-09, r2.x);
    r2.x = sqrt(r2.x);
    r0.yz = r0.yz / r2.xx;
    r0.yz = r0.yz * r0.ww;
    r0.yz = r0.yz * float2(0.5,0.5) + float2(0.5,0.5);
    r2.xy = float2(126.732674,126.732674) * r0.yz;
    r2.zw = cmp(r2.xy >= -r2.xy);
    r2.xy = frac(abs(r2.xy));
    r2.xy = r2.zw ? r2.xy : -r2.xy;
    r3.xyzw = DamageSampler.SampleLevel(DamageSampler_s, r0.yz, 0).xyzw;
    r0.yz = -r2.xy * float2(0.00789062493,0.00789062493) + r0.yz;
    r4.xyzw = float4(0.00789062493,0,0,0.00789062493) + r0.yzyz;
    r5.xyzw = DamageSampler.SampleLevel(DamageSampler_s, r4.xy, 0).xyzw;
    r4.xyzw = DamageSampler.SampleLevel(DamageSampler_s, r4.zw, 0).xyzw;
    r0.yz = float2(0.00789062493,0.00789062493) + r0.yz;
    r7.xyzw = DamageSampler.SampleLevel(DamageSampler_s, r0.yz, 0).xyzw;
    r0.yz = float2(1,1) + -r2.xy;
    r3.xyzw = r3.xyzw * r0.yyyy;
    r5.xyzw = r5.xyzw * r2.xxxx;
    r5.xyzw = r5.xyzw * r0.zzzz;
    r3.xyzw = r3.xyzw * r0.zzzz + r5.xyzw;
    r4.xyzw = r4.xyzw * r0.yyyy;
    r3.xyzw = r4.xyzw * r2.yyyy + r3.xyzw;
    r4.xyzw = r7.xyzw * r2.xxxx;
    r2.xyzw = r4.xyzw * r2.yyyy + r3.xyzw;
    r0.y = r1.w / BoundRadius;
    r0.y = min(1, r0.y);
    r2.xyzw = r2.xyzw * r0.yyyy;
    r2.xyzw = r2.xyzw * float4(0.5,0.5,0.5,0.5) + float4(0.5,0.5,0.5,0.5);
  } else {
    r2.xyzw = v1.xyzw;
  }
  r3.x = v4.x;
  r3.w = 1;
  o4.xyzw = bDebugDisplayDamageScale ? r3.xxxw : r2.xyzw;
  r0.xyzw = gWorldViewProj._m10_m11_m12_m13 * r0.xxxx;
  r0.xyzw = r6.xxxx * gWorldViewProj._m00_m01_m02_m03 + r0.xyzw;
  r0.xyzw = r6.zzzz * gWorldViewProj._m20_m21_m22_m23 + r0.xyzw;
  r0.xyzw = gWorldViewProj._m30_m31_m32_m33 + r0.xyzw;
  r2.xyz = -gViewInverse._m30_m31_m32 + r1.xyz;
  r1.w = dot(r2.xyz, r2.xyz);
  r2.w = sqrt(r1.w);
  r3.x = -globalFogParams[0].x + r2.w;
  r3.x = max(0, r3.x);
  r2.w = r3.x / r2.w;
  r2.w = r2.z * r2.w;
  r3.y = globalFogParams[2].z * r2.w;
  r2.w = cmp(0.00999999978 < abs(r2.w));
  r3.z = -1.44269502 * r3.y;
  r3.z = exp2(r3.z);
  r3.z = 1 + -r3.z;
  r3.y = r3.z / r3.y;
  r2.w = r2.w ? r3.y : 1;
  r3.y = globalFogParams[1].w * r3.x;
  r2.w = r3.y * r2.w;
  r2.w = min(1, r2.w);
  r2.w = 1.44269502 * r2.w;
  r2.w = exp2(r2.w);
  r2.w = min(1, r2.w);
  r2.w = 1 + -r2.w;
  r3.y = globalFogParams[2].y * r2.w;
  r1.w = rsqrt(r1.w);
  r2.xyz = r2.xyz * r1.www;
  r1.w = saturate(dot(r2.xyz, globalFogParams[4].xyz));
  r1.w = log2(r1.w);
  r1.w = globalFogParams[4].w * r1.w;
  r1.w = exp2(r1.w);
  r2.x = saturate(dot(r2.xyz, globalFogParams[3].xyz));
  r2.x = log2(r2.x);
  r2.x = globalFogParams[3].w * r2.x;
  r2.x = exp2(r2.x);
  r2.y = -r2.w * globalFogParams[2].y + 1;
  r2.z = -globalFogParams[2].x + r3.x;
  r2.z = max(0, r2.z);
  r2.yz = globalFogParams[1].yx * r2.yz;
  r2.z = 1.44269502 * r2.z;
  r2.z = exp2(r2.z);
  r2.z = 1 + -r2.z;
  o5.w = saturate(r2.y * r2.z + r3.y);
  r2.z = -globalFogParams[1].z * r3.x;
  r2.z = 1.44269502 * r2.z;
  r2.z = exp2(r2.z);
  r2.z = 1 + -r2.z;
  r3.xyz = globalFogColorMoon.xyz + -globalFogColorE.xyz;
  r3.xyz = r1.www * r3.xyz + globalFogColorE.xyz;
  r4.xyz = globalFogColor.xyz + -r3.xyz;
  r3.xyz = r2.xxx * r4.xyz + r3.xyz;
  r3.xyz = -globalFogColorN.xyz + r3.xyz;
  r2.xzw = r2.zzz * r3.xyz + globalFogColorN.xyz;
  r3.x = globalFogColor.w + -r2.x;
  r3.y = globalFogColorE.w + -r2.z;
  r3.z = globalFogColorN.w + -r2.w;
  o5.xyz = r2.yyy * r3.xyz + r2.xzw;
  o7.x = dot(r0.xyzw, ClipPlanes.xyzw);
  o0.xy = v2.xy;
  o0.zw = v3.xy;
  o2.xyz = r1.xyz;
  o2.w = 1;
  o6.xyzw = r0.xyzw;
  o7.yzw = float3(0,0,0);
  return;
}