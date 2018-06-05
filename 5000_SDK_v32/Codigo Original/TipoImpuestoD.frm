
[Forma]
Clave=TipoImpuestoD
Icono=0
Modulos=(Todos)
Nombre=Detalle del Tipo Impuesto

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.TipoImpuesto
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=325
PosicionInicialArriba=235
PosicionInicialAlturaCliente=403
PosicionInicialAncho=789
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TipoImpuestoD
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
ListaEnCaptura=(Lista)


FiltroGeneral=TipoImpuestoD.TipoImpuesto=<T>{Info.TipoImpuesto}<T>
[Lista.TipoImpuestoD.FechaD]
Carpeta=Lista
Clave=TipoImpuestoD.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.TipoImpuestoD.Concepto]
Carpeta=Lista
Clave=TipoImpuestoD.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.TipoImpuestoD.Referencia]
Carpeta=Lista
Clave=TipoImpuestoD.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
FechaD=94
FechaA=94
Porcentaje=64
Concepto=190
Referencia=157

Tasa=52

CodigoFiscal=160
[Lista.TipoImpuestoD.Tasa]
Carpeta=Lista
Clave=TipoImpuestoD.Tasa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.TipoImpuestoD.CodigoFiscal]
Carpeta=Lista
Clave=TipoImpuestoD.CodigoFiscal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Eliminar
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
ActivoCondicion=No TipoImpuestoD:TipoImpuestoD.TieneMovimientos
Visible=S


[Lista.ListaEnCaptura]
(Inicio)=TipoImpuestoD.FechaD
TipoImpuestoD.FechaD=TipoImpuestoD.Tasa
TipoImpuestoD.Tasa=TipoImpuestoD.CodigoFiscal
TipoImpuestoD.CodigoFiscal=TipoImpuestoD.Concepto
TipoImpuestoD.Concepto=TipoImpuestoD.Referencia
TipoImpuestoD.Referencia=(Fin)



[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Eliminar
Eliminar=(Fin)
