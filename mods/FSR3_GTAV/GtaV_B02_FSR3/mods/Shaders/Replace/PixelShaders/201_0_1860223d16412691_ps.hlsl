// ---- FNV Hash 1860223d16412691

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov 11 18:21:54 2023

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

cbuffer misc_globals : register(b2)
{
  float4 globalFade : packoffset(c0);
  float globalHeightScale : packoffset(c1);
  float globalShaderQuality : packoffset(c1.y);
  float globalReuseMe00001 : packoffset(c1.z);
  float globalReuseMe00002 : packoffset(c1.w);
  float4 POMFlags : packoffset(c2);
  float4 g_Rage_Tessellation_CameraPosition : packoffset(c3);
  float4 g_Rage_Tessellation_CameraZAxis : packoffset(c4);
  float4 g_Rage_Tessellation_ScreenSpaceErrorParams : packoffset(c5);
  float4 g_Rage_Tessellation_LinearScale : packoffset(c6);
  float4 g_Rage_Tessellation_Frustum[4] : packoffset(c7);
  float4 g_Rage_Tessellation_Epsilons : packoffset(c11);
  float4 globalScalars : packoffset(c12);
  float4 globalScalars2 : packoffset(c13);
  float4 globalScalars3 : packoffset(c14);
  float4 globalScreenSize : packoffset(c15);
  uint4 gTargetAAParams : packoffset(c16);
  float4 colorize : packoffset(c17);
  float4 gGlobalParticleShadowBias : packoffset(c18);
  float gGlobalParticleDofAlphaScale : packoffset(c19);
  float gGlobalFogIntensity : packoffset(c19.y);
  float4 gPlayerLFootPos : packoffset(c20);
  float4 gPlayerRFootPos : packoffset(c21);
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

cbuffer megashader_locals : register(b12)
{
  float emissiveMultiplier : packoffset(c0);
  float useTessellation : packoffset(c0.y);
  float HardAlphaBlend : packoffset(c0.z);
  float4 matMaterialColorScale : packoffset(c1);
}

cbuffer csmshader : register(b6)
{
  float4 gCSMShaderVars_shared[12] : packoffset(c0);
  float4 gCSMDepthBias : packoffset(c12);
  float4 gCSMDepthSlopeBias : packoffset(c13);
  float4 gCSMResolution : packoffset(c14);
  float4 gCSMShadowParams : packoffset(c15);
  row_major float4x4 gLocalLightShadowData[8] : packoffset(c16);
  float4 gShadowTexParam : packoffset(c48);
}

SamplerState DiffuseSampler_s : register(s0);
SamplerComparisonState gCSMShadowTextureSamp_s : register(s15);
Texture2D<float4> DiffuseSampler : register(t0);
Texture2D<float4> gCSMShadowTexture : register(t15);


// 3Dmigoto declarations
#define cmp -


void main(
  linear centroid float4 v0 : COLOR0,
  float3 v1 : TEXCOORD0,
  float4 v2 : TEXCOORD1,
  float4 v3 : TEXCOORD6,
  float4 v4 : SV_Position0,
  float4 v5 : SV_ClipDistance0,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float o1 : SV_Target1,
  out float o2 : SV_Target2,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3,r4,r5,r6;
  uint4 bitmask, uiDest;
  float4 fDest;

  float4 x0[4];
  r0.xyz = -gViewInverse._m30_m31_m32 + v3.xyz;
  r1.xyz = gCSMShaderVars_shared[1].xyz * r0.yyy;
  r0.xyw = r0.xxx * gCSMShaderVars_shared[0].xyz + r1.xyz;
  r0.xyz = r0.zzz * gCSMShaderVars_shared[2].xyz + r0.xyw;
  r1.xyz = r0.xyz * gCSMShaderVars_shared[4].xyz + gCSMShaderVars_shared[8].xyz;
  x0[0].xyz = r1.xyz;
  r0.w = max(abs(r1.x), abs(r1.y));
  r1.xyz = r0.xyz * gCSMShaderVars_shared[5].xyz + gCSMShaderVars_shared[9].xyz;
  x0[1].xyz = r1.xyz;
  r1.x = max(abs(r1.x), abs(r1.y));
  r1.yzw = r0.xyz * gCSMShaderVars_shared[6].xyz + gCSMShaderVars_shared[10].xyz;
  r0.xyz = r0.xyz * gCSMShaderVars_shared[7].xyz + gCSMShaderVars_shared[11].xyz;
  x0[2].xyz = r1.yzw;
  r1.y = max(abs(r1.y), abs(r1.z));
  x0[3].xyz = r0.xyz;
  r0.x = max(abs(r0.x), abs(r0.y));
  r0.x = saturate(r0.x * 15 + -6.30000019);
  r2.yw = float2(-0.346096516,0.32848981) * gCSMResolution.zw;
  r0.y = -gCSMResolution.z * 1.5 + 1;
  r0.y = 0.5 * r0.y;
  r0.z = cmp(r1.y < r0.y);
  r0.z = r0.z ? 2 : 3;
  r1.x = cmp(r1.x < r0.y);
  r0.y = cmp(r0.w < r0.y);
  r0.z = r1.x ? 1 : r0.z;
  r0.y = r0.y ? 0 : r0.z;
  r1.xyz = x0[r0.y+0].xyz;
  r0.y = (int)r0.y;
  r3.xyzw = cmp(float4(0,1,2,3) == r0.yyyy);
  r0.y = 0.5 + r0.y;
  r0.y = 0.25 * r0.y;
  r4.y = r1.y * 0.25 + r0.y;
  r3.xyzw = r3.xyzw ? float4(1,1,1,1) : 0;
  r0.y = dot(r3.xyzw, gCSMDepthBias.xyzw);
  r0.z = dot(r3.xyzw, gCSMDepthSlopeBias.xyzw);
  r0.w = cmp(r0.y != 0.000000);
  r0.y = r1.z + -r0.y;
  r3.z = ddx(r0.y);
  r5.w = ddy(r0.y);
  r4.x = 0.5 + r1.x;
  r3.xyw = ddx(r4.xyy);
  r5.xyz = ddy(r4.yxy);
  r1.xy = r3.yw * r5.yw;
  r6.xy = r3.xz * r5.xz + -r1.xy;
  r1.x = r5.y * r3.z;
  r6.z = r3.x * r5.w + -r1.x;
  r1.x = 1 / r6.x;
  r1.xy = r6.yz * r1.xx;
  r1.xy = max(float2(0,0), r1.xy);
  r1.xy = min(float2(0.5,0.5), r1.xy);
  r0.y = -r0.z * r1.x + r0.y;
  r0.y = -r0.z * r1.y + r0.y;
  r2.z = r0.w ? r0.y : r1.z;
  r4.z = 0;
  r0.yzw = r4.xyz + r2.ywz;
  r1.x = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r0.yz, r0.w).x;
  r2.xy = float2(-0.799291492,0.201740593) * gCSMResolution.zw;
  r0.yzw = r2.xyz + r4.xyz;
  r1.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r0.yz, r0.w).x;
  r2.xy = float2(-0.0311755072,0.179337755) * gCSMResolution.zw;
  r0.yzw = r2.xyz + r4.xyz;
  r1.z = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r0.yz, r0.w).x;
  r2.xy = float2(0.514749467,0.253502458) * gCSMResolution.zw;
  r0.yzw = r2.xyz + r4.xyz;
  r1.w = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r0.yz, r0.w).x;
  r2.xy = float2(-0.0728697181,0.00809734128) * gCSMResolution.zw;
  r0.yzw = r2.xyz + r4.xyz;
  r3.x = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r0.yz, r0.w).x;
  r2.xy = float2(-0.96978128,0.0345216095) * gCSMResolution.zw;
  r0.yzw = r2.xyz + r4.xyz;
  r3.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r0.yz, r0.w).x;
  r2.xy = float2(0.545546651,0.0241285414) * gCSMResolution.zw;
  r0.yzw = r2.xyz + r4.xyz;
  r3.z = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r0.yz, r0.w).x;
  r2.xy = float2(-0.0289061088,-0.136784583) * gCSMResolution.zw;
  r0.yzw = r2.xyz + r4.xyz;
  r3.w = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r0.yz, r0.w).x;
  r1.xyzw = r3.xyzw + r1.xyzw;
  r2.xy = float2(-0.47951147,-0.244832873) * gCSMResolution.zw;
  r0.yzw = r2.xyz + r4.xyz;
  r3.x = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r0.yz, r0.w).x;
  r2.xy = float2(0.758788407,-0.112109199) * gCSMResolution.zw;
  r0.yzw = r2.xyz + r4.xyz;
  r3.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r0.yz, r0.w).x;
  r2.xy = float2(0.339352578,-0.249327824) * gCSMResolution.zw;
  r0.yzw = r2.xyz + r4.xyz;
  r3.z = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r0.yz, r0.w).x;
  r2.xy = float2(1.07059765,0.208122596) * gCSMResolution.zw;
  r0.yzw = r2.xyz + r4.xyz;
  r3.w = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r0.yz, r0.w).x;
  r1.xyzw = r3.xyzw + r1.xyzw;
  r3.z = r2.z;
  r5.z = r3.z;
  r6.z = r5.z;
  r6.xy = float2(-1.34315288,-0.088584058) * gCSMResolution.zw;
  r0.yzw = r6.xyz + r4.xyz;
  r6.w = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r0.yz, r0.w).x;
  r2.xy = float2(1.29403818,-0.0180776753) * gCSMResolution.zw;
  r0.yzw = r2.xyz + r4.xyz;
  r6.x = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r0.yz, r0.w).x;
  r3.xy = float2(-0.747563064,-0.113974348) * gCSMResolution.zw;
  r0.yzw = r3.xyz + r4.xyz;
  r6.y = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r0.yz, r0.w).x;
  r5.xy = float2(0.94772172,-0.248763546) * gCSMResolution.zw;
  r0.yzw = r5.xyz + r4.xyz;
  r6.z = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r0.yz, r0.w).x;
  r1.xyzw = r6.xyzw + r1.xyzw;
  r0.y = dot(r1.xyzw, float4(1,1,1,1));
  r1.xyz = gViewInverse._m30_m31_m32 + -v3.xyz;
  r0.z = dot(r1.xyz, gViewInverse._m20_m21_m22);
  r0.z = saturate(r0.z * gCSMShaderVars_shared[0].w + gCSMShaderVars_shared[1].w);
  r0.z = 1 + -r0.z;
  r0.x = r0.z * r0.x;
  r0.x = r0.y * 0.0625 + r0.x;
  r0.x = r0.x * r0.x;
  r0.x = min(1, r0.x);
  r0.y = saturate(v3.z * gCSMShaderVars_shared[3].x + gCSMShaderVars_shared[3].y);
  r0.y = sqrt(r0.y);
  r0.y = gCSMShaderVars_shared[3].z * r0.y;
  r0.x = r0.y * -r0.x + r0.x;
  r0.y = 1 + -globalScalars2.z;
  r0.z = dot(v2.xyz, v2.xyz);
  r0.z = rsqrt(r0.z);
  r0.w = v2.z * r0.z + gLightNaturalAmbient0.w;
  r1.xyz = v2.xyz * r0.zzz;
  r0.z = gLightNaturalAmbient1.w * r0.w;
  r0.z = max(0, r0.z);
  r2.xyz = gLightArtificialIntAmbient0.xyz * r0.zzz + gLightArtificialIntAmbient1.xyz;
  r2.xyz = globalScalars2.zzz * r2.xyz;
  r3.xyz = gLightArtificialExtAmbient0.xyz * r0.zzz + gLightArtificialExtAmbient1.xyz;
  r4.xyz = gLightNaturalAmbient0.xyz * r0.zzz + gLightNaturalAmbient1.xyz;
  r0.yzw = r3.xyz * r0.yyy + r2.xyz;
  r2.xy = globalScalars.zy * v0.xy;
  r2.xy = r2.xy * r2.xy;
  r0.yzw = r2.yyy * r0.yzw;
  r3.x = gLightArtificialIntAmbient1.w;
  r3.y = gLightArtificialExtAmbient0.w;
  r3.z = gLightArtificialExtAmbient1.w;
  r1.w = saturate(dot(r3.xyz, r1.xyz));
  r1.x = saturate(dot(r1.xyz, -gDirectionalLight.xyz));
  r1.yzw = gDirectionalAmbientColour.xyz * r1.www + r4.xyz;
  r0.yzw = r1.yzw * r2.xxx + r0.yzw;
  r2.xyzw = DiffuseSampler.Sample(DiffuseSampler_s, v1.xy).xyzw;
  r1.yzw = r2.xyz * r2.www;
  r1.yzw = r1.yzw * r1.yzw;
  r0.yzw = r1.yzw * r0.yzw;
  r2.xyz = r1.yzw * r1.xxx;
  r2.xyz = gDirectionalColour.xyz * r2.xyz;
  r0.xyz = r2.xyz * r0.xxx + r0.yzw;
  r0.w = emissiveMultiplier * r2.w;
  r1.x = v0.w * r2.w;
  r1.x = globalScalars.x * r1.x;
  r0.w = globalScalars.w * r0.w;
  r0.w = v0.z * r0.w;
  r0.xyz = r1.yzw * r0.www + r0.xyz;
  o0.xyz = globalScalars3.zzz * r0.xyz;
  o0.w = r1.x;
  r0.x = cmp(0.300000012 < r1.x);
  r0.x = r0.x ? 1.000000 : 0;
  o1.x = v1.z * r0.x;
  o2.x = r0.x;
  return;
}