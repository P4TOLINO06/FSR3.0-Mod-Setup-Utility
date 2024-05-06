// ---- FNV Hash be9b80cca9fa0078

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

cbuffer more_stuff : register(b5)
{
  float4 gEntitySelectColor[2] : packoffset(c0);
  float4 gAmbientOcclusionEffect : packoffset(c2);
  float4 gDynamicBakesAndWetness : packoffset(c3);
  float4 gAlphaRefVec0 : packoffset(c4);
  float4 gAlphaRefVec1 : packoffset(c5);
  float gAlphaTestRef : packoffset(c6);
  bool gTreesUseDiscard : packoffset(c6.y);
  float gReflectionMipCount : packoffset(c6.z);
  float gTransparencyAASamples : packoffset(c6.w);
  bool gUseFogRay : packoffset(c7);
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
SamplerState ReflectionSampler_s : register(s1);
SamplerState FogRaySampler_s : register(s11);
SamplerComparisonState gCSMShadowTextureSamp_s : register(s15);
Texture2D<float4> DiffuseSampler : register(t0);
Texture2D<float4> ReflectionSampler : register(t1);
Texture2D<float4> FogRaySampler : register(t11);
Texture2D<float4> gCSMShadowTexture : register(t15);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : COLOR0,
  float4 v1 : COLOR1,
  float4 v2 : TEXCOORD0,
  float4 v3 : TEXCOORD1,
  float4 v4 : TEXCOORD2,
  float4 v5 : TEXCOORD3,
  float4 v6 : TEXCOORD4,
  float4 v7 : TEXCOORD5,
  float4 v8 : TEXCOORD6,
  float4 v9 : TEXCOORD7,
  float4 v10 : TEXCOORD8,
  float3 v11 : TEXCOORD9,
  float4 v12 : SV_Position0,
  float4 v13 : SV_ClipDistance0,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  float4 r0,r1,r2,r3,r4,r5,r6,r7;
  uint4 bitmask, uiDest;
  float4 fDest;

  float4 x0[4];
  r0.xyzw = DiffuseSampler.Sample(DiffuseSampler_s, v2.xy).xyzw;
  r0.w = v10.w * r0.w;
  r0.xyz = r0.xyz * r0.xyz;
  r1.xyz = -gViewInverse._m30_m31_m32 + v3.xyz;
  r2.xyz = gCSMShaderVars_shared[1].xyz * r1.yyy;
  r2.xyz = r1.xxx * gCSMShaderVars_shared[0].xyz + r2.xyz;
  r2.xyz = r1.zzz * gCSMShaderVars_shared[2].xyz + r2.xyz;
  r3.xyz = r2.xyz * gCSMShaderVars_shared[4].xyz + gCSMShaderVars_shared[8].xyz;
  x0[0].xyz = r3.xyz;
  r4.xyz = r2.xyz * gCSMShaderVars_shared[5].xyz + gCSMShaderVars_shared[9].xyz;
  x0[1].xyz = r4.xyz;
  r5.xyz = r2.xyz * gCSMShaderVars_shared[6].xyz + gCSMShaderVars_shared[10].xyz;
  x0[2].xyz = r5.xyz;
  r2.xyz = r2.xyz * gCSMShaderVars_shared[7].xyz + gCSMShaderVars_shared[11].xyz;
  x0[3].xyz = r2.xyz;
  r1.w = -gCSMResolution.z * 1.5 + 1;
  r1.w = 0.5 * r1.w;
  r2.x = max(abs(r5.x), abs(r5.y));
  r2.x = cmp(r2.x < r1.w);
  r2.x = r2.x ? 2 : 3;
  r2.y = max(abs(r4.x), abs(r4.y));
  r2.y = cmp(r2.y < r1.w);
  r2.x = r2.y ? 1 : r2.x;
  r2.y = max(abs(r3.x), abs(r3.y));
  r1.w = cmp(r2.y < r1.w);
  r1.w = r1.w ? 0 : r2.x;
  r2.xyz = x0[r1.w+0].xyz;
  r1.w = (int)r1.w;
  r2.w = 0.5 + r1.w;
  r2.w = 0.25 * r2.w;
  r3.xyzw = cmp(float4(0,1,2,3) == r1.wwww);
  r3.xyzw = r3.xyzw ? float4(1,1,1,1) : 0;
  r1.w = dot(r3.xyzw, gCSMDepthBias.xyzw);
  r3.x = dot(r3.xyzw, gCSMDepthSlopeBias.xyzw);
  r4.x = 0.5 + r2.x;
  r4.y = r2.y * 0.25 + r2.w;
  r2.x = cmp(r1.w != 0.000000);
  r1.w = r2.z + -r1.w;
  r5.xyw = ddx(r4.xyy);
  r5.z = ddx(r1.w);
  r6.xyz = ddy(r4.yxy);
  r6.w = ddy(r1.w);
  r2.yw = r6.yw * r5.yw;
  r7.xy = r5.xz * r6.xz + -r2.yw;
  r2.y = 1 / r7.x;
  r2.w = r6.y * r5.z;
  r7.z = r5.x * r6.w + -r2.w;
  r2.yw = r7.yz * r2.yy;
  r2.yw = max(float2(0,0), r2.yw);
  r2.yw = min(float2(0.5,0.5), r2.yw);
  r1.w = -r3.x * r2.y + r1.w;
  r1.w = -r3.x * r2.w + r1.w;
  r1.w = r2.x ? r1.w : r2.z;
  r1.w = gCSMShadowTexture.SampleCmpLevelZero(gCSMShadowTextureSamp_s, r4.xy, r1.w).x;
  r2.xyz = v5.xyz * r1.www + v7.xyz;
  r3.xyz = v6.xyz * r1.www + v8.xyz;
  r2.xyz = v9.xyz * r0.www + r2.xyz;
  r3.xyz = v10.xyz * r0.www + r3.xyz;
  r2.xyz = r0.xyz * r2.xyz + r3.xyz;
  r0.xyz = v11.xyz * r0.xyz + r2.xyz;
  o0.w = globalScalars.x * r0.w;
  r2.xyz = gViewInverse._m30_m31_m32 + -v3.xyz;
  r0.w = dot(r2.xyz, r2.xyz);
  r0.w = rsqrt(r0.w);
  r2.xyz = r2.xyz * r0.www;
  r0.w = dot(-r2.xyz, v4.xyz);
  r0.w = r0.w + r0.w;
  r2.xyz = v4.xyz * -r0.www + -r2.xyz;
  r3.xy = saturate(float2(0.00066666666,0.00177619897) * v6.ww);
  r0.w = 1 + -r3.x;
  r1.w = -5 + gReflectionMipCount;
  r2.w = gReflectionMipCount * r0.w;
  r2.w = cmp(r2.w < r1.w);
  r3.x = r0.w * gReflectionMipCount + -5;
  r0.w = r0.w * r0.w;
  r0.w = r0.w * 5 + r1.w;
  r0.w = r2.w ? r3.x : r0.w;
  r2.xyw = float3(-0.25,0.5,0.25) * r2.xyx;
  r1.w = 1 + abs(r2.z);
  r2.xyw = r2.xyw / r1.www;
  r2.xyw = float3(0.75,0.5,0.25) + -r2.xyw;
  r1.w = cmp(0 < r2.z);
  r2.xy = r1.ww ? r2.xy : r2.wy;
  r2.xyzw = ReflectionSampler.SampleLevel(ReflectionSampler_s, r2.xy, r0.w).xyzw;
  r0.w = max(v8.w, v7.w);
  r2.xyz = r2.xyz * r0.www;
  r3.xyz = r2.xyz * r3.yyy;
  r3.xyz = float3(0.681690097,0.681690097,0.681690097) * r3.xyz;
  r2.xyz = r2.xyz * float3(0.318309903,0.318309903,0.318309903) + r3.xyz;
  r0.xyz = r2.xyz * v5.www + r0.xyz;
  if (gUseFogRay != 0) {
    r0.w = dot(r1.xyz, r1.xyz);
    r1.w = sqrt(r0.w);
    r2.x = -globalFogParams[0].x + r1.w;
    r2.x = max(0, r2.x);
    r1.w = r2.x / r1.w;
    r1.w = r1.z * r1.w;
    r2.y = globalFogParams[2].z * r1.w;
    r1.w = cmp(0.00999999978 < abs(r1.w));
    r2.z = -1.44269502 * r2.y;
    r2.z = exp2(r2.z);
    r2.z = 1 + -r2.z;
    r2.y = r2.z / r2.y;
    r1.w = r1.w ? r2.y : 1;
    r2.y = globalFogParams[1].w * r2.x;
    r1.w = r2.y * r1.w;
    r1.w = min(1, r1.w);
    r1.w = 1.44269502 * r1.w;
    r1.w = exp2(r1.w);
    r1.w = min(1, r1.w);
    r1.w = 1 + -r1.w;
    r2.y = globalFogParams[2].y * r1.w;
    r0.w = rsqrt(r0.w);
    r3.xyz = r1.xyz * r0.www;
    r0.w = saturate(dot(r3.xyz, globalFogParams[4].xyz));
    r0.w = log2(r0.w);
    r0.w = globalFogParams[4].w * r0.w;
    r0.w = exp2(r0.w);
    r2.z = saturate(dot(r3.xyz, globalFogParams[3].xyz));
    r2.z = log2(r2.z);
    r2.z = globalFogParams[3].w * r2.z;
    r2.z = exp2(r2.z);
    r1.w = -r1.w * globalFogParams[2].y + 1;
    r1.w = globalFogParams[1].y * r1.w;
    r2.w = -globalFogParams[2].x + r2.x;
    r2.w = max(0, r2.w);
    r2.w = globalFogParams[1].x * r2.w;
    r2.w = 1.44269502 * r2.w;
    r2.w = exp2(r2.w);
    r2.w = 1 + -r2.w;
    r2.y = saturate(r1.w * r2.w + r2.y);
    r2.x = -globalFogParams[1].z * r2.x;
    r2.x = 1.44269502 * r2.x;
    r2.x = exp2(r2.x);
    r2.x = 1 + -r2.x;
    r3.xyz = globalFogColorMoon.xyz + -globalFogColorE.xyz;
    r3.xyz = r0.www * r3.xyz + globalFogColorE.xyz;
    r4.xyz = globalFogColor.xyz + -r3.xyz;
    r3.xyz = r2.zzz * r4.xyz + r3.xyz;
    r3.xyz = -globalFogColorN.xyz + r3.xyz;
    r2.xzw = r2.xxx * r3.xyz + globalFogColorN.xyz;
    r3.x = globalFogColor.w;
    r3.y = globalFogColorE.w;
    r3.z = globalFogColorN.w;
    r3.xyz = r3.xyz + -r2.xzw;
    r2.xzw = r1.www * r3.xyz + r2.xzw;
    r0.w = cmp(0 < gGlobalFogIntensity);
    if (r0.w != 0) {
      r3.xy = globalScreenSize.zw * v12.xy;
      r3.xyzw = FogRaySampler.Sample(FogRaySampler_s, r3.xy).xyzw;
      r0.w = -1 + r3.x;
      r0.w = saturate(gGlobalFogIntensity * r0.w + 1);
    } else {
      r0.w = 1;
    }
    r2.xzw = r2.xzw * r0.www + -r0.xyz;
    r2.xyz = r2.yyy * r2.xzw + r0.xyz;
  } else {
    r0.w = dot(r1.xyz, r1.xyz);
    r1.w = sqrt(r0.w);
    r2.w = -globalFogParams[0].x + r1.w;
    r2.w = max(0, r2.w);
    r1.w = r2.w / r1.w;
    r1.w = r1.z * r1.w;
    r3.x = globalFogParams[2].z * r1.w;
    r1.w = cmp(0.00999999978 < abs(r1.w));
    r3.y = -1.44269502 * r3.x;
    r3.y = exp2(r3.y);
    r3.y = 1 + -r3.y;
    r3.x = r3.y / r3.x;
    r1.w = r1.w ? r3.x : 1;
    r3.x = globalFogParams[1].w * r2.w;
    r1.w = r3.x * r1.w;
    r1.w = min(1, r1.w);
    r1.w = 1.44269502 * r1.w;
    r1.w = exp2(r1.w);
    r1.w = min(1, r1.w);
    r1.w = 1 + -r1.w;
    r3.x = globalFogParams[2].y * r1.w;
    r0.w = rsqrt(r0.w);
    r1.xyz = r1.xyz * r0.www;
    r0.w = saturate(dot(r1.xyz, globalFogParams[4].xyz));
    r0.w = log2(r0.w);
    r0.w = globalFogParams[4].w * r0.w;
    r0.w = exp2(r0.w);
    r1.x = saturate(dot(r1.xyz, globalFogParams[3].xyz));
    r1.x = log2(r1.x);
    r1.x = globalFogParams[3].w * r1.x;
    r1.x = exp2(r1.x);
    r1.y = -r1.w * globalFogParams[2].y + 1;
    r1.z = -globalFogParams[2].x + r2.w;
    r1.z = max(0, r1.z);
    r1.yz = globalFogParams[1].yx * r1.yz;
    r1.z = 1.44269502 * r1.z;
    r1.z = exp2(r1.z);
    r1.z = 1 + -r1.z;
    r1.z = saturate(r1.y * r1.z + r3.x);
    r1.w = -globalFogParams[1].z * r2.w;
    r1.w = 1.44269502 * r1.w;
    r1.w = exp2(r1.w);
    r1.w = 1 + -r1.w;
    r3.xyz = globalFogColorMoon.xyz + -globalFogColorE.xyz;
    r3.xyz = r0.www * r3.xyz + globalFogColorE.xyz;
    r4.xyz = globalFogColor.xyz + -r3.xyz;
    r3.xyz = r1.xxx * r4.xyz + r3.xyz;
    r3.xyz = -globalFogColorN.xyz + r3.xyz;
    r3.xyz = r1.www * r3.xyz + globalFogColorN.xyz;
    r4.x = globalFogColor.w;
    r4.y = globalFogColorE.w;
    r4.z = globalFogColorN.w;
    r4.xyz = r4.xyz + -r3.xyz;
    r1.xyw = r1.yyy * r4.xyz + r3.xyz;
    r1.xyw = r1.xyw + -r0.xyz;
    r2.xyz = r1.zzz * r1.xyw + r0.xyz;
  }
  o0.xyz = globalScalars3.zzz * r2.xyz;
  return;
}