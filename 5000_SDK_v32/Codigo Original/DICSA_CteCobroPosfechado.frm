[Forma]
Clave=DICSA_CteCobroPosfechado
Nombre=Consulta de Cobros Posfechados
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
MenuPrincipal=&Men�

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
Menu=&Men�
UsaTeclaRapida=S
TeclaRapida=F12

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=DICSA_CteCobroPosfechado
ConFuenteEspecial=S
Fuente={Tahoma, 11, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Movimiento<T>
ElementosPorPagina=200
PestanaOtroNombre=S
MenuLocal=S
ListaAcciones=(Lista)
IconosNombre=DICSA_CteCobroPosfechado:Movimiento

[Lista.Columnas]
Ejercicio=38
Ventas=183
Devoluciones=177
ChequesDevueltos=179
DiasPromedioCobro=108
0=198
1=129

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

[Lista.FechaEmision]
Carpeta=Lista
Clave=FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Concepto]
Carpeta=Lista
Clave=Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Referencia]
Carpeta=Lista
Clave=Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ImporteTotal]
Carpeta=Lista
Clave=ImporteTotal
Editar=S
Totalizador=0
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Saldo]
Carpeta=Lista
Clave=Saldo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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
NombreDesplegar=Presentaci�n preliminar
EnMenu=S
Carpeta=Lista
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
(Inicio)=FechaEmision
FechaEmision=Concepto
Concepto=Referencia
Referencia=ImporteTotal
ImporteTotal=Saldo
Saldo=(Fin)

[Lista.ListaAcciones]
(Inicio)=Imprimir
Imprimir=Excel
Excel=Preliminar
Preliminar=Personalizar
Personalizar=(Fin)
