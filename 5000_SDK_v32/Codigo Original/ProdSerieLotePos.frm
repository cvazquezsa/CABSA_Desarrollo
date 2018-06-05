[Forma]
Clave=ProdSerieLotePos
Nombre=<T>Posición del Lote<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Origen
PosicionInicialIzquierda=132
PosicionInicialArriba=168
PosicionInicialAltura=289
PosicionInicialAncho=759
PosicionColumna1=49
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.SerieLote
PosicionSeccion1=16
PosicionColumna2=50
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=398

[Origen]
Estilo=Iconos
Clave=Origen
AlineacionAutomatica=S
AcomodarTexto=S
Zona=A1
Vista=ProdSerieLoteFlujoO
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
PestanaOtroNombre=S
MenuLocal=S
ListaAcciones=(Lista)
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
ElementosPorPagina=200
IconosSubTitulo=<T>Lote Origen<T>
MostrarConteoRegistros=S
ListaEnCaptura=(Lista)
IconosNombre=ProdSerieLoteFlujoO:SerieLote

[Destino]
Estilo=Iconos
Clave=Destino
AlineacionAutomatica=S
AcomodarTexto=S
Zona=A2
Vista=ProdSerieLoteFlujoD
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Lote Destino<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
PestanaOtroNombre=S
MenuLocal=S
ListaAcciones=(Lista)
ListaEnCaptura=(Lista)
MostrarConteoRegistros=S
IconosNombre=ProdSerieLoteFlujoD:ProdSerieLote

[Origen.Columnas]
0=111
1=116

[Destino.Columnas]
0=97
1=152

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

[Acciones.IrO]
Nombre=IrO
Boton=0
NombreDesplegar=&Retroceder
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Antes=S
Visible=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+R
ActivoCondicion=ConDatos(ProdSerieLoteFlujoO:SerieLote)
AntesExpresiones=Asigna(Info.SerieLote, ProdSerieLoteFlujoO:SerieLote)

[Acciones.IrD]
Nombre=IrD
Boton=0
NombreDesplegar=&Avanzar
EnMenu=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Visible=S
Antes=S
UsaTeclaRapida=S
TeclaRapida=Ctrl+A
ActivoCondicion=ConDatos(ProdSerieLoteFlujoD:ProdSerieLote)
AntesExpresiones=Asigna(Info.SerieLote, ProdSerieLoteFlujoD:ProdSerieLote)

[(Variables).Info.Mov]
Carpeta=(Variables)
Clave=Info.Mov
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Plata

[(Variables).Info.MovID]
Carpeta=(Variables)
Clave=Info.MovID
Editar=S
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Plata
Pegado=S

[Acciones.Retroceder]
Nombre=Retroceder
Boton=24
NombreDesplegar=Retroceder
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(ProdSerieLoteFlujoO:SerieLote)
AntesExpresiones=Asigna(Info.SerieLote, ProdSerieLoteFlujoO:SerieLote)

[Acciones.Avanzar]
Nombre=Avanzar
Boton=25
NombreDesplegar=Avanzar
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
ConCondicion=S
Antes=S
Visible=S
EjecucionCondicion=ConDatos(ProdSerieLoteFlujoD:ProdSerieLote)
AntesExpresiones=Asigna(Info.SerieLote, ProdSerieLoteFlujoD:ProdSerieLote)

[Destino.Cantidad]
Carpeta=Destino
Clave=Cantidad
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Destino.Unidad]
Carpeta=Destino
Clave=Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Destino.Movimiento]
Carpeta=Destino
Clave=Movimiento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Origen.Movimiento]
Carpeta=Origen
Clave=Movimiento
Editar=S
Totalizador=0
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Origen.Cantidad]
Carpeta=Origen
Clave=Cantidad
Editar=S
Totalizador=1
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Origen.Unidad]
Carpeta=Origen
Clave=Unidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.MovPropiedadesO]
Nombre=MovPropiedadesO
Boton=0
NombreDesplegar=&Propiedades
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
ActivoCondicion=ConDatos(ProdSerieLoteFlujoD:ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, ProdSerieLoteFlujoD:ID)
Visible=S

[Acciones.MovPropiedadesD]
Nombre=MovPropiedadesD
Boton=0
NombreDesplegar=&Propiedades
EnMenu=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovPropiedades
ActivoCondicion=ConDatos(ProdSerieLoteFlujoD:ID)
Antes=S
AntesExpresiones=Asigna(Info.Modulo, <T>INV<T>)<BR>Asigna(Info.ID, ProdSerieLoteFlujoD:ID)
Visible=S

[Forma.ListaCarpetas]
(Inicio)=Origen
Origen=Destino
Destino=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Retroceder
Retroceder=Avanzar
Avanzar=(Fin)

[Origen.ListaAcciones]
(Inicio)=IrO
IrO=MovPropiedadesO
MovPropiedadesO=(Fin)

[Origen.ListaEnCaptura]
(Inicio)=Movimiento
Movimiento=Cantidad
Cantidad=Unidad
Unidad=(Fin)

[Destino.ListaAcciones]
(Inicio)=IrD
IrD=MovPropiedadesD
MovPropiedadesD=(Fin)

[Destino.ListaEnCaptura]
(Inicio)=Movimiento
Movimiento=Cantidad
Cantidad=Unidad
Unidad=(Fin)
