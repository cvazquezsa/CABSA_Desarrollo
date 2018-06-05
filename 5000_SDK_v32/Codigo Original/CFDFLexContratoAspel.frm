
[Forma]
Clave=CFDFLexContratoAspel
Icono=0
Modulos=(Todos)
Nombre=Contrato Timbrado Aspel

ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Modulo,Info.Clave)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=431
PosicionInicialArriba=136
PosicionInicialAlturaCliente=511
PosicionInicialAncho=738
ExpresionesAlMostrar=ProcesarSQL(<T>EXEC spCFDFLexContratoAspelObtener :nEstacion, :tEmpresa<T>,EstacionTrabajo, Info.Empresa)
[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDFLexContratoAspel
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
AlinearTodaCarpeta=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General

FiltroGeneral=CFDFLexContratoAspel.Estacion = {EstacionTrabajo}
[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S




[Acciones.Continuar]
Nombre=Continuar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Continuar
GuardarAntes=S
EnBarraHerramientas=S
BtnResaltado=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S



















Multiple=S
ListaAccionesMultiples=(Lista)

ActivoCondicion=CFDFLexContratoAspel.Aceptar
[Acciones.Continuar.Firmar]
Nombre=Firmar
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S




Expresion=EjecutarSQL(<T>EXEC spCFDFLexContratoAspelFirmar :nEstacion, :tEmpresa<T>, EstacionTrabajo, Info.Empresa)
[Acciones.Continuar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Continuar.Contrato]
Nombre=Contrato
Boton=0
TipoAccion=Formas
ClaveAccion=CFDFLexContratoFirmadoAspel
Activo=S
Visible=S



[Ficha.CFDFLexContratoAspel.Contrato]
Carpeta=Ficha
Clave=CFDFLexContratoAspel.Contrato
Editar=S
LineaNueva=S
3D=S
ConScroll=S
SinRecapitular=S
Tamano=100x30
ColorFondo=Blanco

[Ficha.CFDFLexContratoAspel.Aceptar]
Carpeta=Ficha
Clave=CFDFLexContratoAspel.Aceptar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco














[Acciones.Continuar.ListaAccionesMultiples]
(Inicio)=Firmar
Firmar=Cerrar
Cerrar=Contrato
Contrato=(Fin)


[Ficha.ListaEnCaptura]
(Inicio)=CFDFLexContratoAspel.Contrato
CFDFLexContratoAspel.Contrato=CFDFLexContratoAspel.Aceptar
CFDFLexContratoAspel.Aceptar=(Fin)













[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Continuar
Continuar=(Fin)
