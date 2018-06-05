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

[Acciones.ArtInfo]
Nombre=ArtInfo
Boton=34
NombreDesplegar=&Artículo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ArtInfo
Activo=S
Visible=S
NombreEnBoton=S

[Acciones.Detalle]
Nombre=Detalle
Boton=0
UsaTeclaRapida=S
TeclaRapida=Ctrl+D
NombreDesplegar=Detalles
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=
Expresion=Forma(<T>ArtAlmDesglose<T>)
VisibleCondicion=Info.ArtTipo noen (TipoNormal,TipoServicio)

[Acciones.Detalles]
Nombre=Detalles
Boton=47
NombreDesplegar=&Desglose
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Antes=S
EspacioPrevio=S
NombreEnBoton=S
Expresion=Si<BR> Info.ArtTipo en (TipoSerie, TipoVIN, TipoLote) y Config.SeriesLotesMayoreo<BR>Entonces<BR>  Forma(<T>ArtAlmDesgloseSerieLote<T>)<BR>Sino<BR>  Si(Info.ArtTipo=TipoPartida,Forma(<T>ArtAlmDesglosePartida<T>),Forma(<T>ArtAlmDesglose<T>))<BR>Fin
AntesExpresiones=Asigna(Info.Almacen, ArtAlmExistencias:Almacen)
VisibleCondicion=(Info.ArtTipo noen (TipoNormal,TipoServicio)) o (Info.ArtTipoOpcion<>TipoNo)

[Existencias]
Estilo=Ficha
Clave=Existencias
AlineacionAutomatica=S
AcomodarTexto=S
Zona=A1
Vista=ArtAlmExistencias
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S

[Existencias.Columnas]
Concepto=152
Empresa=77
Articulo=147
Almacen=64
Cantidad=50
0=111
1=82

[Forma]
Clave=ArtAlmExistencia
Nombre=e(<T>Disponible de<T>)+<T> <T>+Info.Articulo+<T> - <T>+Info.Almacen
Icono=6
Modulos=(Todos)
ListaCarpetas=Existencias
CarpetaPrincipal=Existencias
PosicionInicialIzquierda=332
PosicionInicialArriba=262
PosicionInicialAltura=143
PosicionInicialAncho=701
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaExclusiva=S
VentanaEscCerrar=S
VentanaBloquearAjuste=S
EsConsultaExclusiva=S
PosicionInicialAlturaCliente=166

[Existencias.Disponible]
Carpeta=Existencias
Clave=Disponible
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Plata
ColorFuente=$00808040
Efectos=[Negritas]
EspacioPrevio=N

[Existencias.Reservado]
Carpeta=Existencias
Clave=Reservado
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Plata
ColorFuente=Azul
Efectos=[Negritas]
Pegado=N

[Existencias.Articulo]
Carpeta=Existencias
Clave=Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
Efectos=[Negritas]

[Existencias.Descripcion]
Carpeta=Existencias
Clave=Descripcion
Editar=S
3D=S
Tamano=57
ColorFondo=Plata
LineaNueva=N
ValidaNombre=S
Efectos=[Negritas]

[Existencias.Existencias]
Carpeta=Existencias
Clave=Existencias
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Plata
Efectos=[Negritas]
Pegado=N

[Existencias.PorProcesar]
Carpeta=Existencias
Clave=PorProcesar
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Plata
ColorFuente=$00000040
Efectos=[Negritas]

[Existencias.ExistenciaAlterna]
Carpeta=Existencias
Clave=ExistenciaAlterna
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=17
ColorFondo=Plata
Efectos=[Negritas]

[Acciones.PorRecibir]
Nombre=PorRecibir
Boton=59
NombreDesplegar=por &Recibir
EnBarraHerramientas=S
TipoAccion=Expresion
Visible=S
NombreEnBoton=S
EspacioPrevio=S
Expresion=Si<BR>  ArtAlmExistencias:SeCompra y ArtAlmExistencias:SeProduce<BR>Entonces<BR>  Dialogo(<T>porRecibir<T>)<BR>Sino<BR>  Si(ArtAlmExistencias:SeProduce, Forma(<T>ArtProdPendiente<T>), Forma(<T>ArtCompraPendiente<T>))<BR>Fin
ActivoCondicion=Usuario.ConsultarCompraPendiente

[Acciones.PorSuritir]
Nombre=PorSuritir
Boton=58
NombreEnBoton=S
NombreDesplegar=por &Surtir
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ArtVentaPendiente
Visible=S
ActivoCondicion=ArtAlmExistencias:SeVende

[Existencias.Remisionado]
Carpeta=Existencias
Clave=Remisionado
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Plata
ColorFuente=$00000040
Efectos=[Negritas]

[Existencias.Localizacion]
Carpeta=Existencias
Clave=Localizacion
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Plata
Pegado=N
LineaNueva=S
EspacioPrevio=S

[Acciones.Plan]
Nombre=Plan
Boton=88
NombreDesplegar=&Plan
EnBarraHerramientas=S
TipoAccion=Expresion
Antes=S
Visible=S
NombreEnBoton=S
Expresion=Si(ArtAlmExistencias:Espacios, CalendarioReservaciones(ArtAlmExistencias:Articulo, <T><T>), ReportePantalla(<T>PlanArtAlm<T>))
ActivoCondicion=ArtAlmExistencias:Espacios o Usuario.ConsultarCompraPendiente
AntesExpresiones=Asigna(Info.Articulo, ArtAlmExistencias:Articulo)<BR>Asigna(Info.Descripcion, ArtAlmExistencias:Descripcion)<BR>Asigna(Info.ArtTipoOpcion, ArtAlmExistencias:TipoOpcion)

[Acciones.Sustitutos]
Nombre=Sustitutos
Boton=30
NombreEnBoton=S
NombreDesplegar=S&ustitutos
EnBarraHerramientas=S
TipoAccion=Formas
Visible=S
EspacioPrevio=S
ClaveAccion=ArtSustitutoDisponible
ActivoCondicion=ArtAlmExistencias:TieneSustitutos

[Existencias.Pasillo]
Carpeta=Existencias
Clave=Pasillo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Plata

[Existencias.Anaquel]
Carpeta=Existencias
Clave=Anaquel
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Plata

[Existencias.Estante]
Carpeta=Existencias
Clave=Estante
Editar=S
ValidaNombre=S
3D=S
Tamano=19
ColorFondo=Plata

[Acciones.Unidades]
Nombre=Unidades
Boton=65
NombreEnBoton=S
NombreDesplegar=&Unidades
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ArtUnidadDisponible
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Disponible, ArtAlmExistencias:Disponible)
Visible=S

[Existencias.Apartado]
Carpeta=Existencias
Clave=Apartado
Editar=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=Plata
ColorFuente=Azul
Efectos=[Negritas]


[Existencias.ListaEnCaptura]
(Inicio)=Articulo
Articulo=Descripcion
Descripcion=Disponible
Disponible=Reservado
Reservado=Apartado
Apartado=Remisionado
Remisionado=PorProcesar
PorProcesar=ExistenciaAlterna
ExistenciaAlterna=Existencias
Existencias=Localizacion
Localizacion=Pasillo
Pasillo=Anaquel
Anaquel=Estante
Estante=(Fin)



[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=ArtInfo
ArtInfo=Plan
Plan=Unidades
Unidades=PorRecibir
PorRecibir=PorSuritir
PorSuritir=Sustitutos
Sustitutos=Detalles
Detalles=(Fin)
