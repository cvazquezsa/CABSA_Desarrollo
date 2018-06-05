[Forma]
Clave=DICSA_CteRef
Nombre=Referencias Comerciales
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=149
PosicionInicialArriba=155
PosicionInicialAlturaCliente=686
PosicionInicialAncho=982
AccionesTamanoBoton=19x5
Menus=S
BarraAcciones=S
ListaAcciones=Cerrar
AccionesCentro=S
AccionesDivision=S
PosicionSeccion1=37
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionColumna2=39
MenuPrincipal=&Menú

[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=DICSA_Cte
Fuente={Tahoma, 11, Negro, []}
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
ConFuenteEspecial=S

[Ficha.Cliente]
Carpeta=Ficha
Clave=Cliente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.Nombre]
Carpeta=Ficha
Clave=Nombre
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=63
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.Direccion]
Carpeta=Ficha
Clave=Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=63
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Ficha.DireccionNumero]
Carpeta=Ficha
Clave=DireccionNumero
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Observaciones]
Carpeta=Ficha
Clave=Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=63
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Colonia]
Carpeta=Ficha
Clave=Colonia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Delegacion]
Carpeta=Ficha
Clave=Delegacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.CodigoPostal]
Carpeta=Ficha
Clave=CodigoPostal
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Poblacion]
Carpeta=Ficha
Clave=Poblacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Estado]
Carpeta=Ficha
Clave=Estado
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Pais]
Carpeta=Ficha
Clave=Pais
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.Telefonos]
Carpeta=Ficha
Clave=Telefonos
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=42
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.RFC]
Carpeta=Ficha
Clave=RFC
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Cerrar]
Nombre=Cerrar
Boton=0
NombreDesplegar=<T>F12 - Cerrar<T>
EnMenu=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
Menu=&Menú
UsaTeclaRapida=S
TeclaRapida=F12
GuardarAntes=S

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=DICSA_CteRef
ConFuenteEspecial=S
Fuente={Tahoma, 11, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
PestanaOtroNombre=S
Filtros=S
PermiteEditar=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
ListaEnCaptura=(Lista)
ValidarCampos=S
ListaCamposAValidar=DICSA_CteRef.Proveedor
FiltroGeneral=DICSA_CteRef.Cliente=<T>{Info.Cliente}<T>

[Lista.Columnas]
Ejercicio=38
Ventas=183
Devoluciones=177
ChequesDevueltos=179
DiasPromedioCobro=108
0=198
1=129
Fecha=124
Proveedor=196
Direccion=213
Telefonos=128
Fax=150
Contacto=181
Puesto=223
TiempoOperacion=90
CreditoMaximo=133
Plazo=84
Documenta=84
TiempoExcedePago=103
DevuelveCheques=94
DevuelveMercancia=100
PagaConDescuentos=107
TiempoLiquidaChDev=170

[Acciones.Excel]
Nombre=Excel
Boton=0
NombreDesplegar=Enviar a E&xcel
EnMenu=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=0
NombreDesplegar=Imprimir
EnMenu=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=0
NombreDesplegar=Presentación preliminar
EnMenu=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=0
NombreDesplegar=Personalizar Vista
EnMenu=S
EspacioPrevio=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Lista.DICSA_CteRef.Fecha]
Carpeta=Lista
Clave=DICSA_CteRef.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.DICSA_CteRef.Proveedor]
Carpeta=Lista
Clave=DICSA_CteRef.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[RefDetalle.DICSA_CteRef.Fecha]
Carpeta=RefDetalle
Clave=DICSA_CteRef.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[RefDetalle.DICSA_CteRef.Proveedor]
Carpeta=RefDetalle
Clave=DICSA_CteRef.Proveedor
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[RefDetalle.DICSA_CteRef.Direccion]
Carpeta=RefDetalle
Clave=DICSA_CteRef.Direccion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[RefDetalle.DICSA_CteRef.Telefonos]
Carpeta=RefDetalle
Clave=DICSA_CteRef.Telefonos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[RefDetalle.DICSA_CteRef.Fax]
Carpeta=RefDetalle
Clave=DICSA_CteRef.Fax
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[RefDetalle.DICSA_CteRef.Contacto]
Carpeta=RefDetalle
Clave=DICSA_CteRef.Contacto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[RefDetalle.DICSA_CteRef.Puesto]
Carpeta=RefDetalle
Clave=DICSA_CteRef.Puesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[RefDetalle.DICSA_CteRef.TiempoOperacion]
Carpeta=RefDetalle
Clave=DICSA_CteRef.TiempoOperacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[RefDetalle.DICSA_CteRef.CreditoMaximo]
Carpeta=RefDetalle
Clave=DICSA_CteRef.CreditoMaximo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[RefDetalle.DICSA_CteRef.Plazo]
Carpeta=RefDetalle
Clave=DICSA_CteRef.Plazo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[RefDetalle.DICSA_CteRef.Documenta]
Carpeta=RefDetalle
Clave=DICSA_CteRef.Documenta
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[RefDetalle.DICSA_CteRef.TiempoExcedePago]
Carpeta=RefDetalle
Clave=DICSA_CteRef.TiempoExcedePago
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[RefDetalle.DICSA_CteRef.DevuelveCheques]
Carpeta=RefDetalle
Clave=DICSA_CteRef.DevuelveCheques
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[RefDetalle.DICSA_CteRef.DevuelveMercancia]
Carpeta=RefDetalle
Clave=DICSA_CteRef.DevuelveMercancia
Editar=S
LineaNueva=N
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[RefDetalle.DICSA_CteRef.PagaConDescuentos]
Carpeta=RefDetalle
Clave=DICSA_CteRef.PagaConDescuentos
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[RefDetalle.DICSA_CteRef.TiempoLiquidaChDev]
Carpeta=RefDetalle
Clave=DICSA_CteRef.TiempoLiquidaChDev
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.DICSA_CteRef.Direccion]
Carpeta=Lista
Clave=DICSA_CteRef.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.DICSA_CteRef.Telefonos]
Carpeta=Lista
Clave=DICSA_CteRef.Telefonos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.DICSA_CteRef.Fax]
Carpeta=Lista
Clave=DICSA_CteRef.Fax
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.DICSA_CteRef.Contacto]
Carpeta=Lista
Clave=DICSA_CteRef.Contacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.DICSA_CteRef.Puesto]
Carpeta=Lista
Clave=DICSA_CteRef.Puesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.DICSA_CteRef.TiempoOperacion]
Carpeta=Lista
Clave=DICSA_CteRef.TiempoOperacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.DICSA_CteRef.CreditoMaximo]
Carpeta=Lista
Clave=DICSA_CteRef.CreditoMaximo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.DICSA_CteRef.Plazo]
Carpeta=Lista
Clave=DICSA_CteRef.Plazo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.DICSA_CteRef.Documenta]
Carpeta=Lista
Clave=DICSA_CteRef.Documenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.DICSA_CteRef.TiempoExcedePago]
Carpeta=Lista
Clave=DICSA_CteRef.TiempoExcedePago
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.DICSA_CteRef.DevuelveCheques]
Carpeta=Lista
Clave=DICSA_CteRef.DevuelveCheques
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.DICSA_CteRef.DevuelveMercancia]
Carpeta=Lista
Clave=DICSA_CteRef.DevuelveMercancia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.DICSA_CteRef.PagaConDescuentos]
Carpeta=Lista
Clave=DICSA_CteRef.PagaConDescuentos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.DICSA_CteRef.TiempoLiquidaChDev]
Carpeta=Lista
Clave=DICSA_CteRef.TiempoLiquidaChDev
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=Ficha
Ficha=Lista
Lista=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=Cliente
Cliente=Nombre
Nombre=RFC
RFC=Direccion
Direccion=DireccionNumero
DireccionNumero=Colonia
Colonia=Observaciones
Observaciones=Delegacion
Delegacion=CodigoPostal
CodigoPostal=Poblacion
Poblacion=Estado
Estado=Pais
Pais=Telefonos
Telefonos=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=DICSA_CteRef.Fecha
DICSA_CteRef.Fecha=DICSA_CteRef.Proveedor
DICSA_CteRef.Proveedor=DICSA_CteRef.Direccion
DICSA_CteRef.Direccion=DICSA_CteRef.Telefonos
DICSA_CteRef.Telefonos=DICSA_CteRef.Fax
DICSA_CteRef.Fax=DICSA_CteRef.Contacto
DICSA_CteRef.Contacto=DICSA_CteRef.Puesto
DICSA_CteRef.Puesto=DICSA_CteRef.TiempoOperacion
DICSA_CteRef.TiempoOperacion=DICSA_CteRef.CreditoMaximo
DICSA_CteRef.CreditoMaximo=DICSA_CteRef.Plazo
DICSA_CteRef.Plazo=DICSA_CteRef.Documenta
DICSA_CteRef.Documenta=DICSA_CteRef.TiempoExcedePago
DICSA_CteRef.TiempoExcedePago=DICSA_CteRef.DevuelveCheques
DICSA_CteRef.DevuelveCheques=DICSA_CteRef.DevuelveMercancia
DICSA_CteRef.DevuelveMercancia=DICSA_CteRef.PagaConDescuentos
DICSA_CteRef.PagaConDescuentos=DICSA_CteRef.TiempoLiquidaChDev
DICSA_CteRef.TiempoLiquidaChDev=(Fin)
