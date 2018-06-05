[Forma]
Clave=CargaCta
Nombre=Carga en Lote
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=283
PosicionInicialArriba=153
PosicionInicialAlturaCliente=383
PosicionInicialAncho=799
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionCol1=621

VentanaEstadoInicial=Normal
VentanaColor=Plata
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CargaCta
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
HojaAjustarColumnas=S
HojaMantenerSeleccion=S

RefrescarAlEntrar=S
HojaColorFondo=Plata
[Lista.CargaCta.Fecha]
Carpeta=Lista
Clave=CargaCta.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.CargaCta.Catalogo]
Carpeta=Lista
Clave=CargaCta.Catalogo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.CargaCta.Observaciones]
Carpeta=Lista
Clave=CargaCta.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.Columnas]
Fecha=78
Catalogo=97
Clave=76
Observaciones=413
ClavePrefijo=64
ClaveFolioInicial=58

[Acciones.Guardar Cambios]
Nombre=Guardar Cambios
Boton=3
NombreDesplegar=Guardar Cambios
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Acciones.Datos]
Nombre=Datos
Boton=47
NombreEnBoton=S
NombreDesplegar=&Datos
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=CargaCtaD
Activo=S
Antes=S
DespuesGuardar=S
Visible=S
ConCondicion=S

EjecucionCondicion=ConDatos(CargaCta:CargaCta.Fecha)
AntesExpresiones=Asigna(Info.ID, CargaCta:CargaCta.ID)<BR>Asigna(Info.PuedeEditar, CargaCta:CargaCta.Estatus=EstatusSinAfectar)
[Acciones.Mapa]
Nombre=Mapa
Boton=35
NombreEnBoton=S
NombreDesplegar=&Mapeo
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CargaCtaMapa
Activo=S
Visible=S
Antes=S
ConCondicion=S

RefrescarDespues=S
EjecucionCondicion=ConDatos(CargaCta:CargaCta.Fecha)
AntesExpresiones=Asigna(Info.ID, CargaCta:CargaCta.ID)<BR>Asigna(Info.Tipo, CargaCta:CargaCta.FormaTipo)<BR>Asigna(Info.PuedeEditar, CargaCta:CargaCta.Estatus=EstatusSinAfectar)
[Acciones.Procesar]
Nombre=Procesar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Procesar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Visible=S
GuardarAntes=S

Expresion=ProcesarSQL(<T>spCargaCta :nID<T>, CargaCta:CargaCta.ID )<BR>Forma.ActualizarForma
ActivoCondicion=CargaCta:CargaCta.Estatus=EstatusSinAfectar
[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=CargaCta
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Ficha.CargaCta.ClavePrefijo]
Carpeta=Ficha
Clave=CargaCta.ClavePrefijo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.CargaCta.ClaveFolioInicial]
Carpeta=Ficha
Clave=CargaCta.ClaveFolioInicial
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
Tamano=20

[Ficha.CargaCta.Clave]
Carpeta=Ficha
Clave=CargaCta.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.CargaCta.FormaTipo]
Carpeta=Ficha
Clave=CargaCta.FormaTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[Ficha.FormaTipo.NombreCorto]
Carpeta=Ficha
Clave=FormaTipo.NombreCorto
Editar=S
LineaNueva=S
3D=S
Tamano=20
ColorFondo=Plata









[Lista.ListaEnCaptura]
(Inicio)=CargaCta.Catalogo
CargaCta.Catalogo=CargaCta.Fecha
CargaCta.Fecha=CargaCta.Observaciones
CargaCta.Observaciones=(Fin)































[Ficha.ListaEnCaptura]
(Inicio)=CargaCta.Clave
CargaCta.Clave=CargaCta.ClavePrefijo
CargaCta.ClavePrefijo=CargaCta.ClaveFolioInicial
CargaCta.ClaveFolioInicial=CargaCta.FormaTipo
CargaCta.FormaTipo=FormaTipo.NombreCorto
FormaTipo.NombreCorto=(Fin)







[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Guardar Cambios
Guardar Cambios=Datos
Datos=Mapa
Mapa=Procesar
Procesar=(Fin)
