[Forma]
Clave=EspacioInfo
Nombre=Información del Espacio
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=400
PosicionInicialArriba=304
PosicionInicialAlturaCliente=389
PosicionInicialAncho=480
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
MovModulo=ESP
BarraAyuda=S
BarraAyudaBold=S
Comentarios=Info.Espacio
VentanaEscCerrar=S

[Lista.Columnas]
Espacio=64
Nombre=604

[Ficha]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Datos Generales
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Espacio
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S
Pestana=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=Espacio.Espacio=<T>{Info.Espacio}<T>

[Ficha.Espacio.Espacio]
Carpeta=Ficha
Clave=Espacio.Espacio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.Espacio.Nombre]
Carpeta=Ficha
Clave=Espacio.Nombre
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Espacio.Tipo]
Carpeta=Ficha
Clave=Espacio.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Espacio.Estatus]
Carpeta=Ficha
Clave=Espacio.Estatus
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Ficha.Espacio.Alta]
Carpeta=Ficha
Clave=Espacio.Alta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Ficha.Espacio.Baja]
Carpeta=Ficha
Clave=Espacio.Baja
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Ficha.Espacio.UltimoMantenimiento]
Carpeta=Ficha
Clave=Espacio.UltimoMantenimiento
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Tamano=20

[Ficha.Espacio.Observaciones]
Carpeta=Ficha
Clave=Espacio.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Plata
ColorFuente=Negro

[(Carpeta Abrir).Espacio.Nombre]
Carpeta=(Carpeta Abrir)
Clave=Espacio.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[(Carpeta Abrir).Columnas]
0=109
1=312

[Ficha.Espacio.NivelAcceso]
Carpeta=Ficha
Clave=Espacio.NivelAcceso
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Preliminar]
Nombre=Preliminar
Boton=0
NombreDesplegar=Presentación preliminar
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=0
NombreDesplegar=Imprimir
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S
EspacioPrevio=S

[Acciones.Excel]
Nombre=Excel
Boton=0
NombreDesplegar=Enviar a Excel
EnMenu=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=0
NombreDesplegar=&Personalizar Vista
EnMenu=S
EspacioPrevio=S
Carpeta=(Carpeta Abrir)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
Menu=&Archivo
UsaTeclaRapida=S
TeclaRapida=Alt+F4
NombreDesplegar=&Cerrar
EnMenu=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S

[Auto]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Autotransportes
Clave=Auto
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Espacio
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CondicionVisible=General.Autotransportes

[Auto.Espacio.Espacio]
Carpeta=Auto
Clave=Espacio.Espacio
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Auto.Espacio.Nombre]
Carpeta=Auto
Clave=Espacio.Nombre
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Auto.Espacio.Servicio]
Carpeta=Auto
Clave=Espacio.Servicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Auto.Espacio.Rol]
Carpeta=Auto
Clave=Espacio.Rol
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Auto.Espacio.Marca]
Carpeta=Auto
Clave=Espacio.Marca
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Auto.Espacio.Modelo]
Carpeta=Auto
Clave=Espacio.Modelo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Auto.Espacio.Placas]
Carpeta=Auto
Clave=Espacio.Placas
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Auto.Espacio.Legal]
Carpeta=Auto
Clave=Espacio.Legal
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Auto.Espacio.Motor]
Carpeta=Auto
Clave=Espacio.Motor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Auto.Espacio.Chasis]
Carpeta=Auto
Clave=Espacio.Chasis
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Auto.Espacio.TarjetaCirculacion]
Carpeta=Auto
Clave=Espacio.TarjetaCirculacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Auto.Espacio.TarjetaCasetas]
Carpeta=Auto
Clave=Espacio.TarjetaCasetas
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Auto.Espacio.Empresa]
Carpeta=Auto
Clave=Espacio.Empresa
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Auto.Espacio.UltimoMantenimientoKms]
Carpeta=Auto
Clave=Espacio.UltimoMantenimientoKms
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[OtrosDatos]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Otros Datos
Clave=OtrosDatos
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Espacio
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[OtrosDatos.Espacio.Descripcion1]
Carpeta=OtrosDatos
Clave=Espacio.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[OtrosDatos.Espacio.Descripcion2]
Carpeta=OtrosDatos
Clave=Espacio.Descripcion2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[OtrosDatos.Espacio.Descripcion3]
Carpeta=OtrosDatos
Clave=Espacio.Descripcion3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[OtrosDatos.Espacio.Descripcion4]
Carpeta=OtrosDatos
Clave=Espacio.Descripcion4
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[OtrosDatos.Espacio.Descripcion5]
Carpeta=OtrosDatos
Clave=Espacio.Descripcion5
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[OtrosDatos.Espacio.Descripcion6]
Carpeta=OtrosDatos
Clave=Espacio.Descripcion6
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[OtrosDatos.Espacio.Descripcion7]
Carpeta=OtrosDatos
Clave=Espacio.Descripcion7
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[OtrosDatos.Espacio.Descripcion8]
Carpeta=OtrosDatos
Clave=Espacio.Descripcion8
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[OtrosDatos.Espacio.Descripcion9]
Carpeta=OtrosDatos
Clave=Espacio.Descripcion9
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[OtrosDatos.Espacio.Descripcion10]
Carpeta=OtrosDatos
Clave=Espacio.Descripcion10
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[OtrosDatos.Espacio.Espacio]
Carpeta=OtrosDatos
Clave=Espacio.Espacio
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=19
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[OtrosDatos.Espacio.Nombre]
Carpeta=OtrosDatos
Clave=Espacio.Nombre
3D=S
Tamano=30
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Acciones.Plan]
Nombre=Plan
Boton=88
Menu=&Ver
UsaTeclaRapida=S
TeclaRapida=Mayús+Ctrl+P
NombreDesplegar=&Plan
EnBarraHerramientas=S
EnMenu=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
Expresion=CalendarioReservaciones(<T><T>, Espacio:Espacio.Espacio)

[ActivoF]
Estilo=Iconos
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Activos Fijos (Asignados)
Clave=ActivoF
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=ActivoF
Fuente={Tahoma, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosNombre=ActivoF:ActivoF.Articulo
IconosSubTitulo=<T>Artículo<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=ActivoF.Espacio=<T>{Info.Espacio}<T>
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

[ActivoF.Art.Descripcion1]
Carpeta=ActivoF
Clave=Art.Descripcion1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[ActivoF.ActivoF.Serie]
Carpeta=ActivoF
Clave=ActivoF.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[ActivoF.ActivoF.Almacen]
Carpeta=ActivoF
Clave=ActivoF.Almacen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[ActivoF.ActivoF.Categoria]
Carpeta=ActivoF
Clave=ActivoF.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[ActivoF.Columnas]
0=122
1=138

[FormaExtraValor]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Características
Clave=FormaExtraValor
Filtros=S
OtroOrden=S
RefrescarAlEntrar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=FormaExtraValor
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaSinBorde=S
HojaFondoGris=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
ListaOrden=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=FormaExtraValor.Aplica=<T>Espacios<T> AND FormaExtraValor.AplicaClave=<T>{Espacio:Espacio.Espacio}<T>

[FormaExtraValor.VerCampo]
Carpeta=FormaExtraValor
Clave=VerCampo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata
ColorFuente=Negro

[FormaExtraValor.VerValor]
Carpeta=FormaExtraValor
Clave=VerValor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[FormaExtraValor.Columnas]
VerCampo=213
VerValor=225

[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Auto
Auto=OtrosDatos
OtrosDatos=ActivoF
ActivoF=FormaExtraValor
FormaExtraValor=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Plan
Plan=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=Espacio.Espacio
Espacio.Espacio=Espacio.Nombre
Espacio.Nombre=Espacio.Tipo
Espacio.Tipo=Espacio.Estatus
Espacio.Estatus=Espacio.NivelAcceso
Espacio.NivelAcceso=Espacio.Alta
Espacio.Alta=Espacio.Baja
Espacio.Baja=Espacio.UltimoMantenimiento
Espacio.UltimoMantenimiento=Espacio.Observaciones
Espacio.Observaciones=(Fin)

[Auto.ListaEnCaptura]
(Inicio)=Espacio.Espacio
Espacio.Espacio=Espacio.Nombre
Espacio.Nombre=Espacio.Servicio
Espacio.Servicio=Espacio.Rol
Espacio.Rol=Espacio.Marca
Espacio.Marca=Espacio.Modelo
Espacio.Modelo=Espacio.Placas
Espacio.Placas=Espacio.Empresa
Espacio.Empresa=Espacio.Motor
Espacio.Motor=Espacio.Chasis
Espacio.Chasis=Espacio.Legal
Espacio.Legal=Espacio.TarjetaCirculacion
Espacio.TarjetaCirculacion=Espacio.TarjetaCasetas
Espacio.TarjetaCasetas=Espacio.UltimoMantenimientoKms
Espacio.UltimoMantenimientoKms=(Fin)

[OtrosDatos.ListaEnCaptura]
(Inicio)=Espacio.Espacio
Espacio.Espacio=Espacio.Nombre
Espacio.Nombre=Espacio.Descripcion1
Espacio.Descripcion1=Espacio.Descripcion2
Espacio.Descripcion2=Espacio.Descripcion3
Espacio.Descripcion3=Espacio.Descripcion4
Espacio.Descripcion4=Espacio.Descripcion5
Espacio.Descripcion5=Espacio.Descripcion6
Espacio.Descripcion6=Espacio.Descripcion7
Espacio.Descripcion7=Espacio.Descripcion8
Espacio.Descripcion8=Espacio.Descripcion9
Espacio.Descripcion9=Espacio.Descripcion10
Espacio.Descripcion10=(Fin)

[ActivoF.ListaEnCaptura]
(Inicio)=Art.Descripcion1
Art.Descripcion1=ActivoF.Serie
ActivoF.Serie=ActivoF.Almacen
ActivoF.Almacen=ActivoF.Categoria
ActivoF.Categoria=(Fin)

[FormaExtraValor.ListaEnCaptura]
(Inicio)=VerCampo
VerCampo=VerValor
VerValor=(Fin)

[FormaExtraValor.ListaOrden]
(Inicio)=GrupoOrden<TAB>(Acendente)
GrupoOrden<TAB>(Acendente)=FormaExtraCampo.Orden<TAB>(Acendente)
FormaExtraCampo.Orden<TAB>(Acendente)=(Fin)
