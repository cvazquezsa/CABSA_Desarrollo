[Forma]
Clave=Beneficiario
Nombre=Beneficiarios
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=273
PosicionInicialArriba=273
PosicionInicialAltura=477
PosicionInicialAncho=733
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Moneda, Info.FormaPago)
BarraAyuda=S
PosicionInicialAlturaCliente=450
ExpresionesAlCerrar=Asigna(Info.Moneda, Nulo)<BR>Asigna(Info.FormaPago, Nulo)<BR>Asigna(Info.Instrumento, Nulo)<BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.ClienteNombre, Nulo)

[Lista]
Estilo=Hoja
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Beneficiario
Fuente={MS Sans Serif, 8, Negro, []}
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
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
Filtros=S
FiltroPredefinido=S
FiltroAncho=30
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
FiltroTipo=General
BusquedaRespetarFiltros=S
OtroOrden=S
ListaOrden=Beneficiario.Nombre<TAB>(Acendente)
FiltroGeneral={Si(ConDatos(Info.Moneda), <T>Instrumento.Moneda = <T>+Comillas(Info.Moneda)+Si(ConDatos(Info.FormaPago), <T> AND <T>))+<BR> Si(ConDatos(Info.FormaPago), <T>(Instrumento.FormaPagoCompra = <T>+Comillas(Info.FormaPago)+<T> OR Instrumento.FormaPagoVenta = <T>+Comillas(Info.FormaPago)+<T>)<T>)}

[Lista.Cte.Nombre]
Carpeta=Lista
Clave=Cte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco
ColorFuente=Negro

[Lista.InstitucionFin.Nombre]
Carpeta=Lista
Clave=InstitucionFin.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Nombre=205
Instrumento=65
Beneficiario=64
Nombre_1=181
ID=64
Moneda=60
Nombre_2=85
Cliente=86
Ciudad=73
Estado=67
VerID=64

[Lista.Instrumento.Moneda]
Carpeta=Lista
Clave=Instrumento.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Beneficiario.Nombre]
Carpeta=Lista
Clave=Beneficiario.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Seleccionar]
Nombre=Seleccionar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Seleccionar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Seleccionar
Activo=S
Visible=S

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Registro Insertar
Visible=S
Carpeta=Generales
ActivoCondicion=Usuario.CambioAgregarBeneficiarios

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
ConfirmarAntes=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Visible=S
ActivoCondicion=Beneficiario:Beneficiario.Estatus=EstatusAlta

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

[Lista.Beneficiario.Cliente]
Carpeta=Lista
Clave=Beneficiario.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 1 (Registros)
Activo=S
Visible=S

[Lista.Beneficiario.Beneficiario]
Carpeta=Lista
Clave=Beneficiario.Beneficiario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Transferencia]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Transferencias
Clave=Transferencia
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Beneficiario
Fuente={MS Sans Serif, 8, Negro, []}
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
CondicionEdicion=Beneficiario:Beneficiario.Estatus=EstatusAlta

[Transferencia.Beneficiario.Info1]
Carpeta=Transferencia
Clave=Beneficiario.Info1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Transferencia.Beneficiario.Info2]
Carpeta=Transferencia
Clave=Beneficiario.Info2
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Transferencia.Beneficiario.Info3]
Carpeta=Transferencia
Clave=Beneficiario.Info3
Editar=S
LineaNueva=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Transferencia.Beneficiario.Info4]
Carpeta=Transferencia
Clave=Beneficiario.Info4
Editar=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Transferencia.Beneficiario.Institucion]
Carpeta=Transferencia
Clave=Beneficiario.Institucion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Pegado=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Transferencia.InstitucionFin.Nombre]
Carpeta=Transferencia
Clave=InstitucionFin.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Plata
ColorFuente=Negro

[Transferencia.InstitucionFin.Ciudad]
Carpeta=Transferencia
Clave=InstitucionFin.Ciudad
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[Transferencia.InstitucionFin.Estado]
Carpeta=Transferencia
Clave=InstitucionFin.Estado
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[Transferencia.Beneficiario.InstitucionUsar]
Carpeta=Transferencia
Clave=Beneficiario.InstitucionUsar
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Transferencia.Beneficiario.InfoAd1]
Carpeta=Transferencia
Clave=Beneficiario.InfoAd1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=25
EditarConBloqueo=S
ColorFondo=Blanco
ColorFuente=Negro

[Transferencia.Beneficiario.InfoAd2]
Carpeta=Transferencia
Clave=Beneficiario.InfoAd2
Editar=S
ValidaNombre=S
3D=S
Tamano=25
EditarConBloqueo=S
ColorFondo=Blanco
ColorFuente=Negro

[Transferencia.Beneficiario.InfoAd3]
Carpeta=Transferencia
Clave=Beneficiario.InfoAd3
Editar=S
LineaNueva=N
3D=S
Tamano=25
EditarConBloqueo=S
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=S

[Transferencia.Beneficiario.InfoAd4]
Carpeta=Transferencia
Clave=Beneficiario.InfoAd4
Editar=S
3D=S
Tamano=20
EditarConBloqueo=S
LineaNueva=N
ColorFondo=Blanco
ColorFuente=Negro
ValidaNombre=S

[Transferencia.Beneficiario.Intermediario]
Carpeta=Transferencia
Clave=Beneficiario.Intermediario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Pegado=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Transferencia.InstitucionFinInter.Nombre]
Carpeta=Transferencia
Clave=InstitucionFinInter.Nombre
Editar=S
ValidaNombre=S
3D=S
Tamano=23
ColorFondo=Plata
ColorFuente=Negro

[Transferencia.InstitucionFinInter.Ciudad]
Carpeta=Transferencia
Clave=InstitucionFinInter.Ciudad
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[Transferencia.InstitucionFinInter.Estado]
Carpeta=Transferencia
Clave=InstitucionFinInter.Estado
Editar=S
ValidaNombre=S
3D=S
Pegado=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro

[Transferencia.Beneficiario.IntermediarioUsar]
Carpeta=Transferencia
Clave=Beneficiario.IntermediarioUsar
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Generales]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Datos Generales
Clave=Generales
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Beneficiario
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=(Lista)
CondicionEdicion=Beneficiario:Beneficiario.Estatus=EstatusAlta

[Generales.Beneficiario.Beneficiario]
Carpeta=Generales
Clave=Beneficiario.Beneficiario
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
Efectos=[Negritas]
ColorFuente=Negro

[Generales.Beneficiario.Nombre]
Carpeta=Generales
Clave=Beneficiario.Nombre
Editar=S
3D=S
Tamano=65
ValidaNombre=S
ColorFondo=Blanco
ColorFuente=Negro

[Generales.Beneficiario.Cliente]
Carpeta=Generales
Clave=Beneficiario.Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
EditarConBloqueo=S
ColorFondo=Blanco
ColorFuente=Negro

[Generales.Cte.Nombre]
Carpeta=Generales
Clave=Cte.Nombre
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=44
ColorFondo=Plata
ColorFuente=Negro

[Generales.Cte.Telefonos]
Carpeta=Generales
Clave=Cte.Telefonos
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Generales.Beneficiario.Instrumento]
Carpeta=Generales
Clave=Beneficiario.Instrumento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Generales.Instrumento.Descripcion]
Carpeta=Generales
Clave=Instrumento.Descripcion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=44
ColorFondo=Plata
ColorFuente=Negro

[Generales.Instrumento.Moneda]
Carpeta=Generales
Clave=Instrumento.Moneda
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Generales.Beneficiario.Estatus]
Carpeta=Generales
Clave=Beneficiario.Estatus
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Transferencia.Beneficiario.InfoAd5]
Carpeta=Transferencia
Clave=Beneficiario.InfoAd5
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Transferencia.Beneficiario.InfoAd6]
Carpeta=Transferencia
Clave=Beneficiario.InfoAd6
Editar=S
ValidaNombre=N
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Transferencia.Beneficiario.InfoAd7]
Carpeta=Transferencia
Clave=Beneficiario.InfoAd7
Editar=S
ValidaNombre=N
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Transferencia.Beneficiario.InfoAd8]
Carpeta=Transferencia
Clave=Beneficiario.InfoAd8
Editar=S
ValidaNombre=N
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EditarConBloqueo=S

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Generales
Generales=Transferencia
Transferencia=(Fin)

[Forma.ListaAcciones]
(Inicio)=Seleccionar
Seleccionar=Guardar Cambios
Guardar Cambios=Nuevo
Nuevo=Eliminar
Eliminar=Navegador
Navegador=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Beneficiario.Beneficiario
Beneficiario.Beneficiario=Beneficiario.Nombre
Beneficiario.Nombre=Beneficiario.Cliente
Beneficiario.Cliente=Cte.Nombre
Cte.Nombre=Instrumento.Moneda
Instrumento.Moneda=InstitucionFin.Nombre
InstitucionFin.Nombre=(Fin)

[Transferencia.ListaEnCaptura]
(Inicio)=Beneficiario.Info1
Beneficiario.Info1=Beneficiario.Info2
Beneficiario.Info2=Beneficiario.Info3
Beneficiario.Info3=Beneficiario.Info4
Beneficiario.Info4=Beneficiario.Institucion
Beneficiario.Institucion=InstitucionFin.Nombre
InstitucionFin.Nombre=InstitucionFin.Ciudad
InstitucionFin.Ciudad=InstitucionFin.Estado
InstitucionFin.Estado=Beneficiario.InstitucionUsar
Beneficiario.InstitucionUsar=Beneficiario.InfoAd1
Beneficiario.InfoAd1=Beneficiario.InfoAd2
Beneficiario.InfoAd2=Beneficiario.InfoAd3
Beneficiario.InfoAd3=Beneficiario.InfoAd4
Beneficiario.InfoAd4=Beneficiario.InfoAd5
Beneficiario.InfoAd5=Beneficiario.InfoAd6
Beneficiario.InfoAd6=Beneficiario.InfoAd7
Beneficiario.InfoAd7=Beneficiario.InfoAd8
Beneficiario.InfoAd8=Beneficiario.Intermediario
Beneficiario.Intermediario=InstitucionFinInter.Nombre
InstitucionFinInter.Nombre=InstitucionFinInter.Ciudad
InstitucionFinInter.Ciudad=InstitucionFinInter.Estado
InstitucionFinInter.Estado=Beneficiario.IntermediarioUsar
Beneficiario.IntermediarioUsar=(Fin)

[Generales.ListaEnCaptura]
(Inicio)=Beneficiario.Beneficiario
Beneficiario.Beneficiario=Beneficiario.Nombre
Beneficiario.Nombre=Beneficiario.Cliente
Beneficiario.Cliente=Cte.Nombre
Cte.Nombre=Cte.Telefonos
Cte.Telefonos=Beneficiario.Instrumento
Beneficiario.Instrumento=Instrumento.Descripcion
Instrumento.Descripcion=Instrumento.Moneda
Instrumento.Moneda=Beneficiario.Estatus
Beneficiario.Estatus=(Fin)
